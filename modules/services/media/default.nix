{ config, pkgs, lib, input, ... }:

{
  imports =
    [ 
      ./azuracast.nix     # AzuraCast Web Radio
      ./calibre.nix       # Calibre Book Server
      ./jellyfin.nix      # Jellyfin Media server
      ./komga.nix         # Komga Comics Server
      ./navidrome.nix     # Navidrome Music Server
    ];
}