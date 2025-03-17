{ config, pkgs, lib, inputs, ... }:

{
  # Gestione di Home Manager.
  programs.home-manager.enable = true;
  # Supporto a pacchetti non free
  nixpkgs.config.allowUnfree = true;

  imports = [
    # Moduli Nix
    ./modules/git           # Git
    ./modules/hypridle  
    ./modules/hyprland      # Composer Hyprland
    ./modules/hyprlock
    ./modules/rofi          # Launcher rofi
    ./modules/spicetify     # Spotify e le sue customizzazioni
    ./modules/stylix        # Configurazione ricing user
    ./modules/swaync        # Notification Manager
    ./modules/waybar        # Status Bar
    ./modules/wlogout       # Logout
    # Servizi
    ./services/rclone.nix   # Rclone
    #./services/syncthing.nix# Syncthing
  ];

  # Informazioni sull'utente
  home = {
    
    username = "paki";
    homeDirectory = "/home/paki";

    # Pacchetti da installare a livello user: per quelli system (es. Twingate) si deve usare configuration.nix.
    packages = with pkgs; [   
      
      # System  
      alacritty               # Terminal
      brightnessctl           # Brightness input
      cachix                  # Cache per pacchetti Nix
      firefox                 # Browser
      git                     # Git
      hypridle                # Gestione idle
      hyprlock                # Lockscreen
      hyprshot                # Screenshot
      killall                 # System Utility 
      libnotify               # Notification test
      networkmanagerapplet    # Network Manager GUI
      obsidian                # Obsidian
      pavucontrol             # Gestione audio
      playerctl               # Media inputs
      swaynotificationcenter  # Centro notifiche
      twingate                # Zero-Trust Tunnel
      waybar                  # Status Bar
      wget                    # Downloader

      # Fonts
      dina-font
      fira-code
      fira-code-symbols
      liberation_ttf
      mplus-outline-fonts.githubRelease
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji

      # App varie
      discord-canary          # Client Discord Vanilla (funziona lo screenshare) 
      fastfetch               # System Info
      ffmpeg                  # Multimedia encoder
      moonlight-qt            # Remote Client
      nitch                   # NixOS info
      obs-studio              # OBS
      okular                  # Visualizzatore Documenti
      parsec-bin              # Parsec Remote Client
      rclone                  # Rclone
      teams-for-linux         # Microsoft Teams
      telegram-desktop        # Telegram
      tree                    # File utility
      vesktop                 # Discord
      vscode-fhs              # VSCode (versione con integrazioni per Nix)
    ];

    # Gestione dotfiles tramite symlink
    file = {
   };

    # Versione iniziale di Home Manager, solitamente non si deve modificare
    stateVersion = "24.11";

    # Variabili d'ambiente dell'utente
    sessionVariables = {
      EDITOR = "nano";
      STEAM_EXTRA_COMPAT_TOOLS_PATH = "\\\${HOME}/.steam/root/compatibilitytools.d";
    };

  };

  # Notifiche di home-manager (home-manager news)
  news.display = lib.mkDefault "silent";

  # Enable simple integrations
  programs.alacritty.enable = lib.mkDefault true;
  programs.hyprlock.enable = lib.mkDefault true;
  programs.wofi.enable = lib.mkDefault true;

  fonts.fontconfig.enable = true;

  # Impostazioni Nix
  nix.package = pkgs.nixVersions.git;  # Assicurati che sia definito
  
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substitute = true;
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  xdg.userDirs.createDirectories = true; 

}
