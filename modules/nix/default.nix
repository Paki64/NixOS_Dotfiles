{ inputs, lib, config, pkgs, ... }:

{
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      plugin-files = "${pkgs.nix-plugins}/lib/nix/plugins";
      trusted-users = [ "root" "@wheel" ];
    };
    # Garbage Collector
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
