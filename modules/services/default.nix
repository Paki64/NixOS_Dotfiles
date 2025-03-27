{ config, pkgs, lib, input, ... }:

{
  imports =
    [ 
      ./network   # Network related services
      ./rclone    # Rclone services
    ];
}