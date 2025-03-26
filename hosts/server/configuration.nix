{ config, pkgs, ... }:

{
  # System dependencies
  imports =
    [ ./hardware-configuration.nix  # Hardware specific configuration
      ./network.nix                 # Network settings
      ./users.nix                   # User settings
      ../../modules                 # Services
    ];

  # Systemd Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # System profile applications
  environment.systemPackages = with pkgs; [
    gh
    git
    sops
    wget
  ];

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

  system.stateVersion = "24.11"; # Original NixOS installation release

}
