{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.media.navidrome.enable = 
      lib.mkEnableOption "starts navidrome server";
  };

  config = lib.mkIf config.modules.services.media.navidrome.enable {
    services.navidrome = {
      enable = true;
      openFirewall = true;
      user = "paki";
      settings = {
        LogLevel = "DEBUG";
        Scanner_Schedule = "@every 24h";
        TranscodingCacheSize = "150MiB";
        MusicFolder = "/home/paki/media/music";
        EnableSharing = true;
      };
    };
  };

}