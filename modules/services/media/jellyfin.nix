{ config, pkgs, lib, input, ... }:

{
  options = {
    modules.services.media.jellyfin.enable = 
      lib.mkEnableOption "enables jellyfin media server";
  };

  config = lib.mkIf config.modules.services.media.jellyfin.enable {

    fileSystems."/var/lib/jellyfin" = {
      device = "/srv/nas/apps/jellyfin";
      options = [ "bind" ];
    };

    fileSystems."/var/lib/jellyseerr/config" = {
      device = "/srv/nas/apps/jellyseerr/config";
      options = [ "bind" ];
    };

    services.jellyfin = {
      enable = true;
      openFirewall = true;
      user="paki";
      group="users";
    };

    services.jellyseerr = {
      enable = true;
      openFirewall = true;
    };

    environment.systemPackages = [
      pkgs.jellyfin
      pkgs.jellyfin-web
      pkgs.jellyfin-ffmpeg
    ];

    # Workaround for Intro Skipper plugin
    nixpkgs.overlays = with pkgs; [
      (
        final: prev:
          {
            jellyfin-web = prev.jellyfin-web.overrideAttrs (finalAttrs: previousAttrs: {
              installPhase = ''
                runHook preInstall

                # this is the important line
                sed -i "s#</head>#<script src=\"configurationpage?name=skip-intro-button.js\"></script></head>#" dist/index.html

                mkdir -p $out/share
                cp -a dist $out/share/jellyfin-web

                runHook postInstall
              '';
            });
          }
      )
    ];

  };

}