{ config, pkgs, lib, input, ... }:

{
  imports =
  [ 
    ./anime.nix   # Sonarr Instance for Anime
    ./tv.nix      # Sonarr Instance for TV Shows
  ];
}