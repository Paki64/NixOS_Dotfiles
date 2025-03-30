{ config, pkgs, ... }:

{
  # System dependencies
  imports =
    [ ./hardware-configuration.nix  # Hardware specific configuration
      ./network.nix                 # Network settings
      ./users.nix                   # User settings
      ../../modules                 # Programs & Services
      ../../secrets                 # Secrets
    ];

  system.stateVersion = "24.11"; # Original NixOS installation release

  # Systemd Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Security settings
  security = {
    rtkit.enable = true;
    sudo.extraConfig = "Defaults pwfeedback";
  };

  # Virtualization / Containers
  virtualisation.libvirtd.enable = true;
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  virtualisation.oci-containers.backend = "docker";

  # Intel VAAPI & QSV Settings
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  }; 
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vaapiVdpau
      intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
      # OpenCL support for intel CPUs before 12th gen
      # see: https://github.com/NixOS/nixpkgs/issues/356535
      # intel-compute-runtime-legacy1 
      vpl-gpu-rt # QSV on 11th gen or newer
      intel-media-sdk # QSV up to 11th gen
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System profile applications
  environment.systemPackages = with pkgs; [
    compose2nix   # Utility for Compose conversion to nix files
    wget          # wget
  ];

  # Custom Modules
  modules = {

    programs = {
      git.enable = true;              # Enables Git and Github CLI (gh), includes LFS support
    };

    services = {
      
      managers = {
        flaresolverr.enable = true;   # TODO Fixes cloudflare issues with parsers
        prowlarr.enale = true;        # TODO Torrent indexer
        radarr.enable = true;         # TODO Movies indexer
        sonarr.anime.enable = true;   # TODO Anime indexer
        sonarr.tv.enable = true;      # TODO Tv Shows indexer
      };
      
      media = {
        calibre.enable = true;        # TODO Enables Calibre book server
        komga.enable = true;          # TODO Enables Komga comics/manga server
        navidrome.enable = true;      # TODO Enables Navidrome music server
        jellyfin.enable = true;       # Enables Jellyfin media server
      };

      network = {
        ddns.enable = true;           # Enables DDNS Auto-Update
        traefik = {
          enable = true;              # Enables Traefik Reverse Proxy
          calibre.enable = true;      # TODO books.pakisrv.com
          komga.enable = true;        # TODO comics.pakisrv.com
          navidrome.enable = true;    # TODO music.pakisrv.com
          jellyfin.enable = true;     # tv.pakisrv.com & request.tv.pakisrv.com
        };
      };
      
      rclone = {          
        enable = true;                # Enables Rclone
        server.enable = true;         # Enables Server mount
      };
    
      homepage.enable = true;         # TODO Enables Homepage dashboard
      qbittorrent.enable = true;      # TODO Enables QBittorrent instance
      syncthing.enable = true;        # TODO Enable Syncthing Sync utility
    
    };
    
  };

}
