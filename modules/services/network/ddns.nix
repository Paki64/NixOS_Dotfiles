{ config, lib, pkgs, ... }:

let 
in {
  options = {
    modules.services.network.ddns.enable = 
      lib.mkEnableOption "enables ddns auto-updater";
  };

  config = lib.mkIf config.modules.services.network.ddns.enable {

  };

}