{ config, pkgs, lib, inputs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gh
    git
    wget
  ];


}