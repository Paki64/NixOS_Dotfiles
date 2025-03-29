{ config, pkgs, lib, input, ... }:

{
  imports =
    [ 
      ./jellyfin.nix      # Media server
    ];
}