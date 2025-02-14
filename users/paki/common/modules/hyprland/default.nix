{ config, pkgs, lib, inputs, ... }:

{

  imports = [ inputs.hyprland.homeManagerModules.default ];

  wayland.windowManager.hyprland = {
    
    # Allow home-manager to configure hyprland
    enable = true;
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
    ];

    settings = {
      
      # Bind funzionanti anche quando l'input è bloccato (es. lockscreen)

      # Mod Keys defined
      "$mod" = "SUPER";       
      "$mod_l" = "SUPER_L";         # Rilascio SUPER
      "$mod2" = "SUPER_SHIFT";      # SUPER+SHIFT  
      "$mod3" = "SUPER ALT";        # SUPER+ALT  
      "$mod4" = "SUPER CTRL";       # SUPER+CTRL
      "$mod5" = "SUPER_SHIFT CTRL"; # SUPER+CTRL+SHIFT

      # Puoi configurare anche combo di flag, ovviamente
      #Keyboard binders
      bind = [
	      "$mod, C, exec, hyprctl dispatch killactive"  # Chiudi la finestra attiva
        "$mod, D, exec, vesktop"                      # Avvia discord
        "$mod, E, exec, nautilus"                     # Apri il file explorer
        "$mod, F, exec, firefox"                      # Apri il browser
	      "$mod, Q, exec, alacritty"                    # Apri il terminale
        "$mod, S, exec, spotify"                      # Apri Spotify
        "$mod, T, exec, telegram-desktop"             # Apri Telegram
        "$mod, V, exec, code"                         # Apri VSCode
        "$mod, RETURN, exec, pkill waybar || waybar"  # Toggle per la waybar    
        "$mod2, C, exec, hyprctl dispatch exit"       # Logout
        

        ", PRINT, exec, hyprshot -m output"           # Screenshot dello schermo
        "SHIFT, PRINT, exec, hyprshot -m window"      # Screenshot della finestra
        
        # Tasti media
        ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
        ", XF86MonBrightnessUp, exec, brightnessctl s +10%"

        "$mod, Tab, cyclenext"                        # change focus to another window
        "$mod, Tab, bringactivetotop"                 # bring it to the top (floating window)
        "$mod, left, movefocus, l"                    # Cambio focus
        "$mod, right, movefocus, r"                   # Cambio focus
        "$mod, up, movefocus, u"                      # Cambio focus
        "$mod, down, movefocus, d"                    # Cambio focus
        "$mod2, left, movewindow, l"                  # Scambio finestre
        "$mod2, right, movewindow, r"                 # Scambio finestre
        "$mod2, up, movewindow, u"                    # Scambio finestre
        "$mod2, down, movewindow, d"                  # Scambio finestre
        "$mod4, left, workspace, e-1"                 # Spostati su workspace precedente
        "$mod4, right, workspace, e+1"                # Spostati su workspace successivo
        "$mod5, left, movetoworkspace, e-1"           # Sposta la finestra su workspace precedente
        "$mod5, right, movetoworkspace, e+1"          # Sposta la finestra su workspace successivo
      ]
      ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
               ]
            ) 9)
        );
      
      # Binds con descrizioni.
      bindd = [ ];

      # Bind che si ripete quando tenuto premuto
      binde = [
        "$mod3, left, resizeactive, -20 0"    # Resize finestre
        "$mod3, right, resizeactive, 20 0"    # Resize finestre
        "$mod3, up, resizeactive, 0 -20"      # Resize finestre
        "$mod3, down, resizeactive, 0 20"     # Resize finestre
      ];

      # Bind funzionanti anche quando l'input è bloccato (es. lockscreen)
      bindl = [
        "$mod, P, exec, playerctl play-pause"
        "$mod, K, exec, playerctl previous"
        "$mod, L, exec, playerctl next"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];

      # Mouse binders
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      # Bind che funzionano solo su pressione lunga
      bindo = [ ];

      # Bind che funziona al rilascio del pulsante
      bindr = [
        "$mod, $mod_l, exec, pkill rofi || rofi -show drun"
      ];

      # Bind combinati
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      # Impostazioni del cursore
      cursor = {
        inactive_timeout = 5;
      };

      # Decorazioni
      decoration = {
        # shadow.offset = "2 3";
        # shadow.color = lib.mkForce "rgba(00000050)";
      };

      # Esecuzioni all'avvio di Hyprland
      exec-once = [
        "waybar"
      ];

      # Variabili d'ambiente
      env = [];

      # Impostazioni generali
      general = {
        border_size = 2;
        layout = "dwindle";
        gaps_in = 4;
        gaps_out = 8;
        resize_on_border = true;
        # "col.active_border" = "rgb(${config.lib.stylix.colors.base08})";
        # "col.inactive_border" = lib.mkForce "rgb(${config.lib.stylix.colors.base01})";
      };

      # Gestures
      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
      };

      # Input settings
      input = {
        kb_layout = "it";
        touchpad = {
          natural_scroll = true;
        };
      };

      # Impostazioni varie
      misc = {
        disable_splash_rendering = true;
        font_family = "Noto Sans";
        disable_hyprland_logo = true;
      };

      # Default monitor configuration
      monitor = lib.mkDefault ", highres, auto, 1"; 

      # Impostazioni finestre
      windowrule = [
        "move onscreen cursor, nm-connection-editor"
        "float, nm-connection-editor"
        "move onscreen cursor, pavucontrol"
        "float, pavucontrol"
        "move onscreen cursor, swaync-client"
        "float, swaync-client"
        "noborder,^(wofi)$"
        "center,^(wofi)$"
        "float,^(steam)$"
        "size 1080 900, ^(steam)$"
        ];
      windowrulev2 = [
        "float, class:(xdg-desktop-portal-gtk)"
        "float, class:^(nwg-look|qt5ct|qt6ct)$"
        "float, class:^(nm-applet|nm-connection-editor|blueman-manager)$"
        "float, class:^(file-roller|org.gnome.FileRoller)$ # archive manager"
        "float, class:([Tt]hunar), title:(File Operation Progress)"
        "float, class:([Tt]hunar), title:(Confirm to replace files)"
        "stayfocused, title:^()$,class:^(steam)$"
        "minsize 1 1, title:^()$,class:^(steam)$"
        "opacity 0.9 0.7, class:^(thunar)$"
        "size 70% 70%, class:^(gnome-system-monitor|org.gnome.SystemMonitor)$"
        "size 70% 70%, class:^(xdg-desktop-portal-gtk)$"
        "size 60% 70%, class:^(qt6ct)$"
        "size 60% 70%, class:^(file-roller|org.gnome.FileRoller)$"
        ];

      };

  };
}
