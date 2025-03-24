{ config, pkgs, ... }:

{

  imports = [
    ./rclone.nix

    ./jellyfin.nix
  ];

}