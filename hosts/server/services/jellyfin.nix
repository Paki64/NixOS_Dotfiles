{ config, lib, pkgs, ... }:

{
  
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user="paki";
  };

  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];

}