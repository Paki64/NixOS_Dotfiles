{ config, lib, pkgs, ... }:

let 
  mountDrive = "Raidrive:/mnt/distrobox";
  mountPath = "/mnt/raidrive";
  configFile = "/etc/rclone-mnt.conf";
  logFile = "/tmp/rclone/rclone-raidrive.log";
  cacheDir = "/tmp/rclone/cache";
in {
  options = {
    modules.services.rclone.raidrive.enable = 
      lib.mkEnableOption "mounts raidrive mount";
  };

  config = lib.mkIf config.modules.services.rclone.raidrive.enable {
    
    # distrobox create --name raidrive --image ubuntu:22.04 --additional-packages "systemd" --root

    # Launches the Raidrive distrobox
    systemd.services.distrobox-raidrive = {
      description = "Launch Distrobox for Raidrive";
      enable = true;
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = "yes";
        Environment     = "PATH=/run/current-system/sw/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin";
        ExecStart = "${pkgs.distrobox}/bin/distrobox enter raidrive";  
      };
    };

    # Shares the Raidrive mounts
    systemd.services.rclone-raidrive = {
      description = "Rclone mount for Raidrive";
      enable = true;
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
      restartIfChanged = true;
      serviceConfig = {
        Type = "notify";
        ExecPreStart = "/bin/fusermount -u ${mountPath} & rm -rf ${cacheDir}";
        ExecStart = "${pkgs.rclone}/bin/rclone mount ${mountDrive} ${mountPath} --config=${configFile} --log-level DEBUG --log-file ${logFile} --allow-other";
        ExecStop = "/bin/fusermount -u ${mountPath}";
        Restart = "on-failure";
        RestartSec = "10s";
        StandardOutput = "journal";
        StandardError = "journal";
        Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
      };
    };      

  };

}