{
  config,
  pkgs,
  lib,
  ...
}: let
  ns = "google-chrome-vpnns";
  nsDns = "10.2.0.1";

  hostVeth = "vchost0";
  nsVeth = "vcns0";

  hostGw = "10.200.50.1";
  hostCIDR = "${hostGw}/24";
  nsCIDR = "10.200.50.2/24";
  subnet = "10.200.50.0/24";

  wanIf = "eno1";

  wgIf = "chromewg";
  wgKeyFile = "/etc/wireguard/${wgIf}.key";

  wgTunnelIP = "10.2.0.2/32";
  wgPeerPublicKey = "C+u+eQw5yWI2APCfVJwW6Ovj3g4IrTOfe+tMZnNz43s=";
  wgEndpoint = "217.138.216.162:51820";
  wgAllowedIPs = ["0.0.0.0/0"];

  entryTarget = "chrome-vpnns";
in {
  #### DNS isolation for the namespace ####
  environment.etc."netns/${ns}/resolv.conf" = {
    text = "nameserver ${nsDns}\n";
    mode = "0644";
  };

  #### NAT must exist before you use the namespace ####
  # This does not “start” anything; it only configures kernel/networking.
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  networking.nat = {
    enable = true;
    internalInterfaces = [hostVeth];
    externalInterface = wanIf;
    internalIPs = [subnet];
  };

  #### 2) Create namespace (on-demand) ####
  systemd.services."netns-${ns}" = {
    description = "Create netns ${ns}";
    after = ["network.target"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      ${pkgs.iproute2}/bin/ip netns add ${ns} 2>/dev/null || true
      ${pkgs.iproute2}/bin/ip netns exec ${ns} ${pkgs.iproute2}/bin/ip link set lo up || true
    '';
  };

  #### 3) veth + IPs (on-demand) ####
  systemd.services."netns-${ns}-veth" = {
    description = "veth for ${ns}";
    after = ["netns-${ns}.service" "network.target"];
    requires = ["netns-${ns}.service"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      ${pkgs.iproute2}/bin/ip link add ${hostVeth} type veth peer name ${nsVeth} 2>/dev/null || true
      ${pkgs.iproute2}/bin/ip link set ${nsVeth} netns ${ns} 2>/dev/null || true

      ${pkgs.iproute2}/bin/ip addr add ${hostCIDR} dev ${hostVeth} 2>/dev/null || true
      ${pkgs.iproute2}/bin/ip link set ${hostVeth} up || true

      ${pkgs.iproute2}/bin/ip netns exec ${ns} ${pkgs.iproute2}/bin/ip addr add ${nsCIDR} dev ${nsVeth} 2>/dev/null || true
      ${pkgs.iproute2}/bin/ip netns exec ${ns} ${pkgs.iproute2}/bin/ip link set ${nsVeth} up || true
    '';
  };

  #### 4) Default route inside namespace (base path) ####
  systemd.services."netns-${ns}-route" = {
    description = "Route for ${ns}";
    after = ["netns-${ns}-veth.service"];
    requires = ["netns-${ns}-veth.service"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      ${pkgs.iproute2}/bin/ip netns exec ${ns} ${pkgs.iproute2}/bin/ip route replace default via ${hostGw}
    '';
  };

  #### 7) WireGuard (module) inside namespace ####
  networking.wireguard.interfaces.${wgIf} = {
    ips = [wgTunnelIP];
    privateKeyFile = wgKeyFile;

    peers = [
      {
        publicKey = wgPeerPublicKey;
        endpoint = wgEndpoint;
        allowedIPs = wgAllowedIPs;
        persistentKeepalive = 25;
      }
    ];

    interfaceNamespace = ns;
    socketNamespace = "init";
    allowedIPsAsRoutes = true;
  };

  #### Ensure WG only starts when our entry target is started ####
  # (WireGuard units exist, but are not wanted by multi-user.target)
  systemd.services."wireguard-${wgIf}".after = [
    "netns-${ns}.service"
    "netns-${ns}-veth.service"
    "netns-${ns}-route.service"
    "network-online.target"
  ];
  systemd.services."wireguard-${wgIf}".requires = [
    "netns-${ns}.service"
    "netns-${ns}-veth.service"
    "netns-${ns}-route.service"
  ];
  systemd.services."wireguard-${wgIf}".wants = ["network-online.target"];

  #### 6) Kill switch (apply AFTER WG is up) ####
  systemd.services."netns-${ns}-killswitch" = {
    description = "Kill switch inside ${ns} (allow only ${wgIf})";
    after = ["wireguard-${wgIf}.service"];
    requires = ["wireguard-${wgIf}.service"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    path = [pkgs.iproute2 pkgs.nftables];

    script = ''
            ${pkgs.iproute2}/bin/ip netns exec ${ns} ${pkgs.nftables}/bin/nft -f - <<'EOF'
      table inet killswitch {
        chain output {
          type filter hook output priority 0; policy drop;

          oifname "lo" accept
          oifname "${wgIf}" accept
          ct state established,related accept
        }
      }
      EOF
    '';
  };

  #### Entry target: start everything ONLY when requested ####
  systemd.targets.${entryTarget} = {
    description = "On-demand VPN namespace for Chrome (${ns})";
    wants = [
      "netns-${ns}.service"
      "netns-${ns}-veth.service"
      "netns-${ns}-route.service"
      "wireguard-${wgIf}.service"
      "netns-${ns}-killswitch.service"
    ];
  };

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "chrome-vpn" ''
      set -euo pipefail

      # Start the on-demand stack (requires privileges)
      systemctl start ${entryTarget}.target

      # Wait for namespace to exist
      for i in $(seq 1 50); do
        if ${pkgs.iproute2}/bin/ip netns list | ${pkgs.gnugrep}/bin/grep -q "^${ns}\b"; then
          break
        fi
        sleep 0.1
      done

      # Launch Chrome inside the namespace as the current user
      exec sudo ${pkgs.iproute2}/bin/ip netns exec ${ns} sudo -u "$USER" google-chrome-stable "$@"
    '')
  ];
}
