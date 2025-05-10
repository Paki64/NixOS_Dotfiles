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
      settings = {
        LogLevel = "DEBUG";
        Scanner_Schedule = "@every 24h";
        TranscodingCacheSize = "150MiB";
        MusicFolder = "/mnt/raidrive/paki/Musica/Soundtracks/Giochi/";
      };
    };
  };

}