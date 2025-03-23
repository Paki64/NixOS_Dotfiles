{ config, pkgs, ... }:

{

  environment.systemPackages = [ pkgs.rclone ];

  fileSystems."/home/paki/mnt/Server" = {
    device = "Server:";
    fsType = "rclone";
    options = [
      "nodev"
      "nofail"
      "allow_other"
      "args2env"
      "config=/home/paki/nixos/dots/common/rclone/rclone.conf"
    ];
  };

}
