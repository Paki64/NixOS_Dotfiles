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

  # System profile applications
  environment.systemPackages = with pkgs; [
    wget  # wget
  ];

  # Custom Modules
  modules = {

    programs = {
      git.enable = true;              # Enables Git and Github CLI (gh), includes LFS support
    };

    services = {
      rclone = {          
        enable = true;                # Enables Rclone
        server.enable = true;         # Enables Server mount
      };
    };
    
  };

}
