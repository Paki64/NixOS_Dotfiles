{ config, lib, pkgs, ... }:

let 
  mountDrive = "Server:";
  mountPath = "/mnt/rclone";
  configFile = "/etc/rclone-mnt.conf";
  logFile = "/tmp/rclone/rclone-server.log";
  cacheDir = "/tmp/rclone/cache";
in {
  options = {
    modules.services.rclone.server.enable = 
      lib.mkEnableOption "mounts server mount";
  };

  config = lib.mkIf config.modules.services.rclone.server.enable {
    
    systemd.services.rclone-server = {
      description = "Rclone mount for Onedrive Server";
      enable = true;
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
      restartIfChanged = true;
      serviceConfig = {
        Type = "notify";
        ExecPreStart = "/bin/fusermount -u /mnt/rclone & rm -rf ${cacheDir}";
        ExecStart = "${pkgs.rclone}/bin/rclone mount ${mountDrive} ${mountPath} --config=${configFile} --log-level DEBUG --log-file ${logFile} --disable-http2 --buffer-size 32M --no-check-certificate --allow-other --vfs-cache-mode full --vfs-cache-max-size 100G --vfs-read-chunk-size 128M --vfs-read-ahead 8G --vfs-cache-max-age 168h --cache-dir ${cacheDir} --onedrive-no-versions --onedrive-chunk-size 250M --dir-cache-time 168h --vfs-read-chunk-size-limit off --vfs-fast-fingerprint --attr-timeout 5000h --poll-interval 1m --ignore-size --bwlimit-file 50M:50M --transfers 5 --checkers 5 --low-level-retries 5";
        ExecStop = "/bin/fusermount -u /mnt/rclone";
        Restart = "on-failure";
        RestartSec = "10s";
        StandardOutput = "journal";
        StandardError = "journal";
        Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
      };
    };      

  };

}