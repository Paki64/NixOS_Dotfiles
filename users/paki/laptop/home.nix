# Inserire quì solo i pacchetti e i file esclusivi per il dispositivo
{ config, pkgs, ... }:

{

  imports = [ 
    ./modules/hyprland
  ];

  home.packages = [ ];

  home.file = { };

}
