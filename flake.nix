{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    nur = {
      url = "github:nix-community/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xremap-flake = {
      url = "github:xremap/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tagstudio = {
      url = "github:TagStudioDev/TagStudio";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    comfyui-nix = {
      url = "github:utensils/comfyui-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {...} @ inputs: let
    systemFor = hostname:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;

          user = rec {
            fullname = "Santiago Fuentes";
            name = "sfuentes";
            mail = "dev@sfuentes.cl";
            inherit hostname;

            # -- Directories
            home = "/home/${name}";
            flake = "${home}/NixOS";
            documents = "${home}/Documents";
            downloads = "${home}/Downloads";
            sync = "${home}/Sync";
            wallpapers = "${documents}/Wallpapers";
            recordings = "${documents}/Recordings";
            screenshots = "${documents}/Screenshots";
            cache = "${home}/.cache";
            config = "${home}/.config";
            data = "${home}/.local/share";
            state = "${home}/.local/state";
          };
        };

        modules = [
          ./hosts/${hostname}
          ./modules/system.nix
          ./modules/user.nix
        ];
      };
  in {
    nixosConfigurations = {
      desktop = systemFor "desktop";
      notebook = systemFor "notebook";
      server = systemFor "server";
    };
  };
}
