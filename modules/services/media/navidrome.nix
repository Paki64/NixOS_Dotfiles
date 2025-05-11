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
      group= "users";
      settings = {
        LogLevel = "DEBUG";
        Scanner_Schedule = "@every 24h";
        TranscodingCacheSize = "500MiB";
        MusicFolder = "/media/music/ost/";
        EnableSharing = true;
        DefaultDownsamplingFormat = "aac";
        ProtectHome = false;
      };
    };
  };

}