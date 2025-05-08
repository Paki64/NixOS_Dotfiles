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
      ./deluge.nix        # Deluge Downloader
      ./homepage.nix      # Homepage Dashboard
      ./syncthing.nix     # Syncthing Sync Manager
    ];
}