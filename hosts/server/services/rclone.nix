{ config, pkgs, ... }:

{

  environment.systemPackages = [ pkgs.rclone ];

/*
  fileSystems."/home/paki/mnt/server" = {
    device = "Server:";
    fsType = "rclone";
    options = [
      "nodev"
      "nofail"
      "allow_other"
      "args2env"
      "config=/home/paki/nixos/dots/common/rclone/rclone.conf"
      "vfs_cache_mode=full"
      "vfs_cache_max_size=300G"
      "vfs_cache_max_age=168h"
      "buffer_size=1G"
      "dir_cache_time=168h"
      "vfs_read_chunk_size=128M"
      "attr_timeout=5000h"
      "poll_interval=30s"
      #"no_checksums"
      #"no_modtime"
    ];
  };

  systemd.services.rclone-server = {
    description = "Rclone mount per Server:";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount Server:/home/paki/mnt/server \
          --config=/home/paki/nixos/dots/common/rclone/rclone.conf \
          --vfs-cache-mode full \
          --vfs-cache-max-size 300G \
          --vfs-cache-max-age 168h \
          --buffer-size 1G \
          --dir-cache-time 168h \
          --vfs-read-chunk-size 128M \
          --attr-timeout 5000h \
          --poll-interval 30s
      '';
      ExecStop = "/run/wrappers/bin/fusermount -u /home/paki/mnt/server";
      Restart = "always";
      RestartSec = "10s";
    };
    wantedBy = [ "multi-user.target" ];
  };

*/

  systemd.user.services.rclone-server = {
    enable = true;
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    description = "Rclone mount for Onedrive Server";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.rclone}/bin/rclone mount Server: /home/paki/mnt/server --config=/home/paki/nixos/dots/common/rclone/rclone.conf'';
    };
  };

}
