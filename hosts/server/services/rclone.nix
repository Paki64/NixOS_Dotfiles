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
      ExecPreStart = "/bin/fusermount -u /mnt/rclone";
      ExecStart = "${pkgs.rclone}/bin/rclone mount Server: /mnt/rclone --config=home/paki/nixos/dots/common/rclone/rclone.conf --log-level DEBUG --log-file /tmp/rclone/rclone-server.log --buffer-size 32M --no-check-certificate --allow-other --vfs-cache-mode full --vfs-cache-max-size 100G --vfs-read-chunk-size 256M --vfs-read-ahead 2G --vfs-cache-max-age 168h --cache-dir /tmp/rclone/cache --checkers 1 --tpslimit 3 --transfers 1 --bwlimit-file 40M:40M --low-level-retries 1 --onedrive-no-versions --onedrive-chunk-size 250M --dir-cache-time 168h --vfs-read-chunk-size 128M --vfs-read-chunk-size-limit off --vfs-fast-fingerprint --attr-timeout 5000h --poll-interval 1m --ignore-size --timeout=1m";
      ExecStop = "/bin/fusermount -u /mnt/rclone";
      Restart = "on-failure";
      RestartSec = "10s";
      StandardOutput = "journal";
      StandardError = "journal";
      Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
    };
  };          


}
