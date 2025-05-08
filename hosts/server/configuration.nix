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
  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  virtualisation.oci-containers.backend = "podman";
  networking.firewall.interfaces."podman+".allowedUDPPorts = [ 53 ];

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
    compose2nix         # Utility for Compose conversion to nix files
    distrobox           # Distrobox for specific use-cases (not declarative scenarios)
    firefox             # Browser for specific use-cases (not declarative scenarios)
    getent              # Requirement for services
    podman              # Requirement for services
    wget                # wget
    xdg-utils           # Xdg-utils for specific use-cases
    xdg-desktop-portal  # Xdg support for gui
  ];

  # Desktop Enviroment
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.flatpak.enable = true;

  # RDP Server
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "startplasma-x11";
  services.xrdp.openFirewall = true;

  # XDG Portal Support
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
  };

  # Enviromental Variables
  environment.sessionVariables = {
    BROWSER = "firefox";
  };

  # Custom Modules
  modules = {

    programs = {
      git.enable = true;              # Enables Git and Github CLI (gh), includes LFS support
    };

    services = {
      managers = {
        flaresolverr.enable = true;   # Fixes cloudflare issues with parsers (localhost:8191)
        prowlarr.enable = true;       # Torrent indexer (localhost:9696)
        radarr.enable = true;         # Movies indexer (localhost:7878)
        sonarr.anime.enable = true;   # TODO Anime indexer
        sonarr.tv.enable = true;      # TODO Tv Shows indexer
      };
      
      media = {
        calibre.enable = true;        # TODO Enables Calibre book server
        komga.enable = true;          # TODO Enables Komga comics/manga server
        navidrome.enable = true;      # TODO Enables Navidrome music server
        jellyfin.enable = true;       # Enables Jellyfin media server (Server:  , Jellyseerr: localhost:5055)
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
        raidrive.enable = true;       # Workaround for Raidrive mounts (Distrobox)
        server.enable = true;         # Enables Server mount
      };
    
      deluge.enable = true;           # Enables Deluge instance (localhost:8112)
      homepage.enable = true;         # TODO Enables Homepage dashboard
      syncthing.enable = true;        # Enable Syncthing Sync utility (localhost:8384)
    
    };
    
  };

}
