{ config, lib, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.rclone ];
  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';
  security.wrappers = {
    fusermount.source  = "${pkgs.fuse}/bin/fusermount";
  };

  systemd.services.rclone-server = {
    description = "Rclone mount for Onedrive Server";
    enable = true;
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "notify";
      ExecStart = "${pkgs.rclone}/bin/rclone mount Server: /home/paki/mnt/server --config=home/paki/nixos/dots/common/rclone/rclone.conf --allow-other --vfs-cache-mode full --vfs-cache-max-size 300G --vfs-read-ahead 2G --vfs-cache-max-age 168h --buffer-size 64M --cache-dir /home/paki/tmp/rclone/cache --checkers 1 --tpslimit 3 --transfers 1 --bwlimit-file 40M:40M --low-level-retries 1 --onedrive-no-versions --onedrive-chunk-size 250M --dir-cache-time 168h --vfs-read-chunk-size 128M --vfs-read-chunk-size-limit off --vfs-fast-fingerprint --attr-timeout 5000h --poll-interval 30s --timeout=1m";
      ExecStop="/bin/fusermount -u %h/mnt/server";
      Restart = "on-failure";
      RestartSec = "10s";
      StandardOutput = "journal";
      StandardError = "journal";
      Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
    };
  };          


}
