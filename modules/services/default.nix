{ config, pkgs, lib, input, ... }:

{
  imports =
    [ 
      # Categories
      ./managers          # Management services
      ./media             # Multimedia related services
      ./network           # Network related services
      ./rclone            # Rclone services
      
      # Services
      ./homepage.nix      # Homepage Dashboard
      ./transmission.nix   # Qbittorrent Downloader
      ./syncthing.nix     # Syncthing Sync Manager
    ];
}