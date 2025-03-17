{ config, pkgs, ... }:

{

  # Rclone-Onedrive: automontaggio di Onedrive tramite rclone
  systemd.user.services.rclone-onedrive = {
    Unit = {
      Description = "Mount di Onedrive.";
      After = [ "network-online.target" ];
    };
    Service = {
      Type = "notify";
      ExecStart = "${pkgs.rclone}/bin/rclone --config=%h/.nixos/dots/common/rclone/rclone.conf --vfs-cache-mode full --ignore-checksum mount \"Paki:\" \"Onedrive\" --volname Onedrive --vfs-cache-max-size 10G";
      ExecStop="/bin/fusermount -u %h/Onedrive/%i";
      Restart = "always";
      RestartSec = 30;
    };
    Install.WantedBy = [ "default.target" ];
  };          

}
