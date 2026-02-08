{
  # SEE: https://github.com/utensils/comfyui-nix
  imports = [inputs.comfyui-nix.nixosModules.default];
  nixpkgs.overlays = [inputs.comfyui-nix.overlays.default];

  services.comfyui = {
    enable = true;
    enableManager = true; # Enable the built-in ComfyUI Manager
    listenAddress = "127.0.0.1";
    port = 8188;
    dataDir = "/var/lib/comfyui";
    openFirewall = false;
    # extraArgs = [ "--lowvram" ];
    # environment = { };
  };
}
