{ config, lib, pkgs, ... }:

let 
  mountDrive = "Raidrive:";
  mountPath = "/home/paki/raidrive";
  configFile = "/etc/rclone-mnt.conf";
  logFile = "/tmp/rclone/rclone-raidrive.log";
  cacheDir = "/tmp/rclone/cache";
in {
  options = {
    modules.services.rclone.raidrive.enable = 
      lib.mkEnableOption "mounts raidrive mount";
  };

  config = lib.mkIf config.modules.services.rclone.raidrive.enable {
    
    systemd.services.rclone-raidrive = {
      description = "Rclone mount for Raidrive";
      enable = true;
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
      restartIfChanged = true;
      serviceConfig = {
        Type = "notify";
        ExecPreStart = "/bin/fusermount -u /home/paki/raidrive & rm -rf ${cacheDir}";
        ExecStart = "${pkgs.rclone}/bin/rclone mount ${mountDrive} ${mountPath} --config=${configFile} --log-level DEBUG --log-file ${logFile}";
        ExecStop = "/bin/fusermount -u /home/paki/raidrive";
        Restart = "on-failure";
        RestartSec = "10s";
        StandardOutput = "journal";
        StandardError = "journal";
        Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
      };
    };      

  };

}