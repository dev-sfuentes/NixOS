{pkgs, ...}: let
in {
  user-manage.services.xremap.config.keymap = [
    # Headphones
    {
      name = "headphones";
      remap = {
        # Volume Up, Max 100%
        volumeup.launch = [
          # Script to prevent volume going up higher than 100
          "${pkgs.writeShellScript "volume-up.sh" ''
            current_volume=$(${pkgs.pulseaudio}/bin/pactl get-sink-volume @DEFAULT_SINK@ | grep 'Volume: front-left' | awk '{print $5}' | sed 's/%//')
            if [ "$current_volume" -lt 100 ]; then
              ${pkgs.pulseaudio}/bin/pactl set-sink-volume 0 +5%
            fi
          ''}"
        ];
        # Volume Down, Min 0%
        volumedown.launch = ["${pkgs.pulseaudio}/bin/pactl" "set-sink-volume" "0" "-5%"];
      };
    }
    # Laziness Mode (To ease closing apps opened through lf)
    {
      name = "laziness-mode";
      application.only = ["imv" "mpv" "vlc"];
      remap.delete.launch = ["hyprctl" "dispatch" "killactive"];
    }
    # Portal Mouse Shortcuts
    {
      name = "portal-mouse";
      application.only = ["org.freedesktop.impl.portal.desktop.kde"];
      remap = {
        # Enter (side button)
        btn_side = "ENTER";
        # Cancel (extra button)
        btn_extra = "ESC";
      };
    }
    # Brave changes
    {
      name = "side-button-save-enter-close";
      application.only = ["brave-browser"];

      remap = {
        # Save (side button)
        btn_side.launch = [
          "${pkgs.wtype}/bin/wtype"
          "-M"
          "ctrl"
          "-P"
          "s"
          "-p"
          "s"
          "-m"
          "ctrl"
        ];
        # Close (extra button)
        btn_extra.launch = [
          "${pkgs.wtype}/bin/wtype"
          "-M"
          "ctrl"
          "-P"
          "w"
          "-p"
          "w"
          "-m"
          "ctrl"
        ];
      };
    }
  ];
}
