{ config, pkgs, lib, input, ... }:

{
  imports =
    [ 
      ./nix       # Nix Settings
      ./programs  # Programs
      ./services  # Services
    ];
}