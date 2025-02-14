{ config, pkgs, ... }:

{
  imports =
    [ 
      # Configurazioni specifiche
      ./hardware-configuration.nix
      ./network.nix
      # Configurazioni generali
      ../common/global
      # Configurazione Stylix
      ./stylix
      # Configurazioni utenti
      ../common/users/paki
    ];

  networking.hostName = "paki-laptop"; # Define your hostname.
  
  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = false;
  services.displayManager.autoLogin.user = "paki";

}
