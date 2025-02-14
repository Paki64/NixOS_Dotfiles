{ pkgs, lib, inputs, ... }:
let
  opacity = lib.mkDefault 0.95;
  fontSize = lib.mkDefault 11;
in
{
  stylix = {
    enable = true;
    image = ./wallpaper.png;
    autoEnable = true;
    targets.qt.platform = "qtct";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
  };
  
}