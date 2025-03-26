{ config, pkgs, lib, ... }:

{

  options = {
    git.enable = 
      lib.mkEnableOption "enables git";
  };

  environment.systemPackages = lib.mkIf config.git.enable [
    pkgs.git   # Git
    pkgs.gh    # Github CLI
  ];

  programs.git = lib.mkIf config.git.enable {
    enable = true;
    lfs.enable = true;
    userName = "Paki64";
    userEmail = "pasqualecriscuolo2010@gmail.com";
  };
}