{ pkgs, lib, inputs, ... }:
let
  opacity = 0.95;
  fontSize = 11;
in
{
  stylix = lib.mkDefault {
    enable = true;
    image = ./wallpaper.png;
    autoEnable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";

    targets = { 
      spicetify.enable = true;
    };

    opacity = {
      terminal = opacity;
      popups = opacity;
    };

    fonts = {
      
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      serif = {
        package = pkgs.aleo-fonts;
        name = "Aleo";
      };
      sansSerif = {
        package = pkgs.noto-fonts-cjk-sans;
        name = "Noto Sans CJK JP";
      };
    
      sizes = {
        applications = fontSize;
        desktop = fontSize;
        popups = fontSize;
        terminal = fontSize;
      };

    };
  };

  # Override per il cursore
  home.pointerCursor =  {
    gtk.enable = true;
    x11.enable = true;
    size = lib.mkForce 16;
  };


  gtk = {
    enable = true;
    font = {
      name = "Noto Sans CJK JP";
    };
  };

}