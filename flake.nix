{
  # Descrizione testuale
  description = "Flakes di configurazione";

  # Tutte le fonti (git repos)
  inputs = {

    # Nixpkgs (non richiede di dichiarare github)
    nixpkgs = {
      url = "nixpkgs/nixos-unstable";
      };

    # Home-Manager
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
      };

    # Hyprland
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprlock.url = "github:hyprwm/hyprlock";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # Spicetify
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stylix: gestore dichiarativa dei dotfiles
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      };

    };



  # I sistemi configurati, si inizia importando le librerie
  outputs = { self,
              nixpkgs, 
              home-manager, 
              hyprland,
              hyprland-plugins,
              hyprlock,
              spicetify-nix, 
              stylix,
              ... 
            }@inputs:

    # Import delle funzioni
    let
      lib = nixpkgs.lib;
    in {

      # Configurazioni dei Sistemi
      nixosConfigurations = {

        Paki-Laptop = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ 
            ./hosts/laptop/configuration.nix
            stylix.nixosModules.stylix
          ];
        };

        Paki-Server = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ 
            ./hosts/server/configuration.nix
          ];
        };

      };


      # Configurazioni degli Utenti
      homeConfigurations = {
        "paki@Paki-Laptop" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          modules = [
            ./users/paki/common/home.nix
            ./users/paki/laptop/home.nix
            stylix.homeManagerModules.stylix
          ];
          extraSpecialArgs = { inherit inputs; };
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
