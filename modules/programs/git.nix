{ config, lib, pkgs, ... }:

{

  options = {
    git.enable = 
      lib.mkEnableOption "enables git";
  };

  config = lib.mkIf config.git.enable {
    
    environment.systemPackages = with pkgs; [
      git   # Git
      gh    # Github CLI
    ];

    programs.git = {
      enable = true;
      lfs.enable = true;
    };

  };

}