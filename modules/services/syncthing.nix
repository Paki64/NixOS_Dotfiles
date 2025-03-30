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
        dataDir = "/home/paki/sync";
        configDir = "/home/paki/sync/.config/syncthing";
        overrideDevices = false;     # overrides any devices added or deleted through the WebUI
        overrideFolders = false;     # overrides any folders added or deleted through the WebUI
        settings = {
          #devices = {
            #"Paki-SteamDeck" = { id = "$(cat ${config.sops.secrets."modules/services/syncthing/devices/deck".path}"; };
            #"desktop" = { id = "DEVICE-ID-GOES-HERE"; };
          #};
          folders = {
            "Saves-Emulation" = {
              path = "/home/paki/sync/emulation";
              #devices = [ "deck" ];
            };
            "Saves-Games" = {
              path = "/home/paki/sync/games";
              #devices = [ "deck" ];
            };
          };
        };
      };
    }; 
  };

}