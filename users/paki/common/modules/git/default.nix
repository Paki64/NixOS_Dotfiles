{ config, pkgs, lib, inputs, ... }:

{
  home.packages = [ pkgs.git pkgs.gh];
  programs.git = {
    enable = true;
    userName = "Paki64";
    userEmail = "pasqualecriscuolo2010@gmail.com";
    lfs.enable = true;
  };
  programs.gh.enable = true;
}