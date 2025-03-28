{ config, pkgs, lib, input, ... }:

{
  imports =
    [ 
      ./jellyfin        # Media server
    ];
}