{ config, pkgs, lib, input, ... }:

{
  imports =
    [ 
      ./media     # Multimedia related services
      ./network   # Network related services
      ./rclone    # Rclone services
    ];
}