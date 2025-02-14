{ pkgs, lib, inputs, ... }:

lib.mkDefault {
  stylix = {
    enable = true;
    image = ./wallpaper.png;
    autoEnable = true;
    targets.qt.platform = "qtct";
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
  };
  
}