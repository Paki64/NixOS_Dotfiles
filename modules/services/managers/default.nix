{ config, pkgs, lib, input, ... }:

{
  imports =
    [ 
      ./flaresolverr.nix  # Bypasses cloudflare for indexers
      ./prowlarr.nix      # Torrent indexer
      ./radarr.nix        # Movie indexer
      ./sonarr            # Tv Show indexer
    ];
}