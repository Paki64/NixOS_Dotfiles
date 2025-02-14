# Hyprlock is a lockscreen for Hyprland
{ config, lib, inputs, ... }:
let
  foreground = "rgba(216, 222, 233, 0.70)";
  imageStr = toString config.stylix.image;
  font = config.stylix.fonts.serif.name;
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 0;
        hide_cursor = true;
        no_fade_in = false;
        disable_loading_bar = false;
        fingerprint.enabled = false;
      };

      # BACKGROUND
      background = {
        monitor = "";
        blur_passes = 0;
        contrast = 0.8916;
        brightness = 0.7172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };

      label = [
        {
          # Day-Month-Date
          monitor = "";
          text = ''cmd[update:1000] echo -e "$(date +"%A %d %B %Y" | sed -E 's/\b(.)/\U\1/g')"'';
          color = foreground;
          font_size = 28;
          font_family = font + " Bold";
          position = "0, 470";
          halign = "center";
          valign = "center";
        }
        # Time
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<span>$(date +"%H:%M")</span>"'';
          color = foreground;
          font_size = 120;
          font_family = font;
          position = "0, 350";
          halign = "center";
          valign = "center";
        }
        # USER
        {
          monitor = "";
          text = ''cmd[update:1000] echo -e "$(getent passwd "$USER" | cut -d ':' -f 5 | cut -d ' ' -f1)"'';
          color = foreground;
          outline_thickness = 2;
          dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          font_size = 16;
          font_family = font + " Bold";
          position = "0, -315";
          halign = "center";
          valign = "center";
        }
      ];

      # INPUT FIELD
      input-field = lib.mkForce {
        monitor = "";
        size = "280, 40";
        outline_thickness = 2;
        dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true;
        outer_color = "rgba(255, 255, 255, 0)";
        inner_color = "rgba(255, 255, 255, 0.1)";
        font_color = foreground;
        fade_on_empty = true;
        font_family = font + " Bold";
        placeholder_text = "";
        hide_input = false;
        position = "0, -375";
        halign = "center";
        valign = "center";
      };
    };
  };
}