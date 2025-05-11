{ config, lib, pkgs, ... }:

{

  options = {
    modules.programs.git.enable = 
      lib.mkEnableOption "enables git";
  };

  config = lib.mkIf config.modules.programs.git.enable {
    
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