{ config, pkgs, ... }:

{
  imports =
    [ ../common/global/locale.nix
      ../common/global/nix.nix
      ../common/users/paki
      ./hardware-configuration.nix
      ./network.nix
      ./programs.nix
      ./virtualization.nix
      ./services
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Security settings
  security = {
    rtkit.enable = true;
    sudo.extraConfig = "Defaults pwfeedback";
  };

  # Services settings
  users.users.paki.linger = true; #Enable lingering for services after logout

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
