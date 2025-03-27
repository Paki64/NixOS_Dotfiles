{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ sops ];

  sops.defaultSopsFile = ./secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/paki/.config/sops/age/keys.txt";

  sops.secrets = {
    
    "common/system/userPassword" = {};
    "common/rclone" = {
      sopsFile = ./rclone.conf.sops;
      format = "binary";
      path = "/home/paki/.config/rclone/rclone.conf";
      owner = "paki";
    };

  };


}