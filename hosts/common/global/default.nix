{ config, pkgs, lib, ... }:

let
  mkDefault = lib.mkDefault;
in
{
  imports =
    [ 
      ./locale.nix
      ./nix.nix
      ../stylix
    ];

  # Grub boot loader
  boot = {
    loader.grub.enable = true;
    loader.grub.devices = [ "nodev" ];
    loader.grub.efiInstallAsRemovable = true;
    loader.grub.efiSupport = true;
    loader.grub.useOSProber = true;
    loader.timeout = 5;
    plymouth.enable = true; # Splashscreen 
  };

  # Hardware settings
  hardware = {
    # Bluetooth
    bluetooth = {
      enable = true;        # enables support for Bluetooth
      powerOnBoot = true;   # powers up the default Bluetooth controller on boot
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  networking = {
    networkmanager.enable = true;       # Enable networking
    hostName = mkDefault "paki-nixos";  # Default hostname    
  };

  # Gnome Desktop Manager
  services.xserver.displayManager.gdm.enable = mkDefault true;
  services.xserver.desktopManager.gnome.enable = mkDefault true;
  security.pam.services.gdm.enableGnomeKeyring = mkDefault true;

  # KDE Plasma Desktop Manager - Ripassarci quando kde6 sarà supportato da stylix
  services.displayManager.sddm.enable = mkDefault false;
  services.desktopManager.plasma6.enable = mkDefault false;
  security.pam.services.sddm.enableKwallet = mkDefault false;

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = mkDefault false;
  services.displayManager.autoLogin.user = mkDefault "paki";

  services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  security = {
    rtkit.enable = mkDefault true;
    sudo.extraConfig = "Defaults pwfeedback";
    pam.services.hyprlock = {};
    pam.services.hyprlock.fprintAuth = false;
  };

  programs.firefox.enable = mkDefault true;
  programs.ssh.startAgent = true;
  # Enable hyprland composer
  programs.hyprland.enable = mkDefault true;
  programs.hyprlock.enable = mkDefault true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty               # Terminal
    cachix                  # Cache per pacchetti Nix
    firefox                 # Browser
    git                     # Git
    killall                 # System Utility 
    twingate                # Zero-Trust Tunnel
    waybar                  # Status Bar
    wget                    # Downloader

  ];

  # Default theme
  stylix.enable = mkDefault true;
  stylix.autoEnable = mkDefault true;
  stylix.base16Scheme = mkDefault "${pkgs.base16-schemes}/share/themes/nord.yaml";

  # Virtualization / Containers
  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;

  # Variabili d'ambiente
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Enables Wayland for some apps
  };
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
