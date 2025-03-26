{ config, pkgs, lib, input, ... }:

{
  imports =
    [ 
      ./server.nix   # Rclone Server (UnionFS)
    ];


  options = {
    rclone.enable = 
      lib.mkEnableOption "enables rclone";
  };


  config = lib.mkIf config.rclone.enable {
    
    # Installs rclone
    environment.systemPackages = with pkgs; [
      rclone  
    ];
    
    # Enable fusermount for system
    environment.etc."fuse.conf".text = ''
      user_allow_other
    '';    
    security.wrappers = {
      fusermount.source  = "${pkgs.fuse}/bin/fusermount";
    };

  };

}