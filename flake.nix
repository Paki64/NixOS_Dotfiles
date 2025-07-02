{
  description = "System flakes";

  # Inputs
  inputs = {

    # Nixpkgs repos
    nixpkgs = {
      url = "nixpkgs/nixos-25.05";
    };

    # Sops: 
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # VSCode Server: remote ssh access for vscode
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";  
    };

  };


  # I sistemi configurati, si inizia importando le librerie
  outputs = { self, nixpkgs, sops-nix, vscode-server, ... }@inputs:

    # Import delle funzioni
    let
      lib = nixpkgs.lib;
    in {

      # Configurazioni dei Sistemi
      nixosConfigurations = {

        server = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ 
            ./hosts/server/configuration.nix
            sops-nix.nixosModules.sops
	          vscode-server.nixosModules.default
            ({ config, pkgs, ... }: {
              programs.nix-ld.enable = true;
              services.vscode-server.enable = true;
            })
          ];
        };

      };
    };

  nixConfig = {
    substituters = [
      "https://cache.nixos.org/"
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };


}
