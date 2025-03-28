{ config, pkgs, ... }:

{
  # System dependencies
  imports =
    [ ./hardware-configuration.nix  # Hardware specific configuration
      ./network.nix                 # Network settings
      ./users.nix                   # User settings
      ../../modules                 # Programs & Services
      ../../secrets                 # Secrets
    ];

  system.stateVersion = "24.11"; # Original NixOS installation release

  # Systemd Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Security settings
  security = {
    rtkit.enable = true;
    sudo.extraConfig = "Defaults pwfeedback";
  };

  # Virtualization / Containers
  virtualisation.libvirtd.enable = true;
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  virtualisation.oci-containers.backend = "docker";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System profile applications
  environment.systemPackages = with pkgs; [
    compose2nix   # Utility for Compose conversion to nix files
    wget          # wget
  ];

  # Custom Modules
  modules = {

    programs = {
      git.enable = true;              # Enables Git and Github CLI (gh), includes LFS support
    };

    services = {
      media = {
        jellyfin.enable = true;       # Enables Jellyfin media server
      };
      network = {
        ddns.enable = true;           # Enables DDNS Auto-Update
        nginx = {
          enable = true;              # Enables Nginx Reverse Proxy
          jellyfin.enable = true;     # jellyfin.pakisrv.com
        };
      };
      rclone = {          
        enable = true;                # Enables Rclone
        server.enable = true;         # Enables Server mount
      };
    };
    
  };

}
