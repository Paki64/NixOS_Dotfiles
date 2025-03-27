{ config, pkgs, lib, input, ... }:

{
  imports =
    [ 
      ./ddns.nix   # DDNS Updater for Cloudflare
    ];

}