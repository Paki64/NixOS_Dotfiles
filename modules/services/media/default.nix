{ config, pkgs, lib, input, ... }:

{
  imports =
    [ 
      ./calibre.nix       # Calibre Book Server
      ./jellyfin.nix      # Jellyfin Media server
      ./komga.nix         # Komga Comics Server
      ./navidrome.nix     # Navidrome Music Server
    ];
}