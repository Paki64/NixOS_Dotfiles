{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.managers.flaresolverr.enable = 
      lib.mkEnableOption "starts flaresolverr instance";
  };

  config = lib.mkIf config.modules.services.managers.flaresolverr.enable {
    
    # Containers
    virtualisation.oci-containers.containers."flaresolverr" = {
      image = "ghcr.io/flaresolverr/flaresolverr:latest";
      environment = {
        "CAPTCHA_SOLVER" = "none";
        "LOG_HTML" = "false";
        "LOG_LEVEL" = "info";
      };
      ports = [
        "8191:8191/tcp"
      ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=flaresolverr"
        "--network=flaresolverr_default"
      ];
    };
    systemd.services."podman-flaresolverr" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-flaresolverr_default.service"
      ];
      requires = [
        "podman-network-flaresolverr_default.service"
      ];
      partOf = [
        "podman-compose-flaresolverr-root.target"
      ];
      wantedBy = [
        "podman-compose-flaresolverr-root.target"
      ];
    };

    # Networks
    systemd.services."podman-network-flaresolverr_default" = {
      path = [ pkgs.podman ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStop = "podman network rm -f flaresolverr_default";
      };
      script = ''
        podman network inspect flaresolverr_default || podman network create flaresolverr_default
      '';
      partOf = [ "podman-compose-flaresolverr-root.target" ];
      wantedBy = [ "podman-compose-flaresolverr-root.target" ];
    };

    # Root service
    systemd.targets."flaresolverr" = {
      unitConfig = {
        Description = "Starts Flaresolverr Service.";
      };
      wantedBy = [ "multi-user.target" ];
    };
  
  };

}