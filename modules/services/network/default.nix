{ config, pkgs, lib, input, ... }:

{
  imports =
    [ 
      ./ddns.nix    # DDNS Updater for Cloudflare
      ./nginx       # Reverse Proxy
      ./traefik     # Reverse Proxy
    ];

}