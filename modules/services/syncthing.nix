{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.syncthing.enable = 
      lib.mkEnableOption "starts syncthing instance";
  };

  config = lib.mkIf config.modules.services.syncthing.enable {
    services = {
      syncthing = {
        enable = true;
        user = "paki";
        group = "users";
        guiAddress = "0.0.0.0:8384";
        dataDir = "/home/paki/sync";
        configDir = "/home/paki/sync/.config/syncthing";
        };
      };
    }; 

}