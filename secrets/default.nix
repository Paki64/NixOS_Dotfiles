{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ sops ];

  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/paki/.config/sops/age/keys.txt";

  sops.secrets = {
    
    "common/system/userPassword" = {};
    "common/rclone" = {
      sopsFile = ../../secrets/rclone.conf.sops;
      format = "binary";
      path = "/etc/rclone-mnt.conf";
    };

  };


}