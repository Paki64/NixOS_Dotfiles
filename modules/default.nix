{ config, pkgs, lib, input, ... }:

{
  imports =
    [ 
      ./programs  # Programs
      ./services  # Services
    ];
}