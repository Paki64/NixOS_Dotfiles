{ config, pkgs, lib, input, ... }:

{
  imports =
    [ 
      ./server.nix   # Rclone Server (UnionFS)
    ];


  options = {
    modules.services.rclone.enable = 
      lib.mkEnableOption "enables rclone";
  };

  
  config = lib.mkMerge [

    # Installs
    (lib.mkIf (config.modules.services.rclone.enable) {    
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
    })
    
    (lib.mkIf (! config.modules.services.rclone.enable) {
      modules.services.rclone = {
        server.enable = lib.mkForce false;
      };
    })
  
  
  ];

}