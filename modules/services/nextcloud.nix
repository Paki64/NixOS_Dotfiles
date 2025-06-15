{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.nextcloud.enable = 
      lib.mkEnableOption "enables nextcloud";
  };

  config = lib.mkIf config.modules.services.nextcloud.enable {

    services.nextcloud = {
      enable = true;
      hostName = "server"; 
      package = pkgs.nextcloud31;
      config.adminpassFile = "/etc/nextcloud-admin-pass";
      config.dbtype = "sqlite";     
      extraApps = {
        inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
      };
      extraAppsEnable = true;
      autoUpdateApps.enable = true;
      database.createLocally = true;
      settings.trusted_domains = [ 
        "cloud.pakisrv.com"
        "server"
      ]; 
      settings.enabledPreviewProviders = [
        "OC\\Preview\\BMP"
        "OC\\Preview\\GIF"
        "OC\\Preview\\JPEG"
        "OC\\Preview\\Krita"
        "OC\\Preview\\MarkDown"
        "OC\\Preview\\MP3"
        "OC\\Preview\\OpenDocument"
        "OC\\Preview\\PNG"
        "OC\\Preview\\TXT"
        "OC\\Preview\\XBitmap"
        "OC\\Preview\\HEIC"
      ];
    };

    services.nginx.virtualHosts."server".listen = [ { addr = "0.0.0.0"; port = 9880; } ];

  };

}