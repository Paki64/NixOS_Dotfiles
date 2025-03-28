{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ sops ];

  sops.defaultSopsFile = ./secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/paki/.config/sops/age/keys.txt";

  sops.secrets = {

    # From secrets.yaml
    "hosts/server/users/paki/password" = {};

    # Dotfiles 
    "dots/ddns" = {
      sopsFile = ./dots/ddns.sops;
      format = "binary";
      path = "/etc/ddns/data/config.json";
    };
    "dots/rclone" = {
      sopsFile = ./dots/rclone.sops;
      format = "binary";
      path = "/etc/rclone-mnt.conf";
    };

  };

}