{ config, pkgs, lib, input, ... }:

{
  imports =
    [ 
      ./rclone   # Git
    ];
}