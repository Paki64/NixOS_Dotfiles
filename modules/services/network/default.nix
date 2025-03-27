{ config, pkgs, lib, input, ... }:

{
  imports =
    [ 
      ./cloudflare-ddns.nix     # Cloudflare DDNS Updater
    ];
}