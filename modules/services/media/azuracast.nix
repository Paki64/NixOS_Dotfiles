{ config, lib, pkgs, ... }:

{
  options = {
    modules.services.media.azuracast.enable = 
      lib.mkEnableOption "starts azuracast server";
  };

  config = lib.mkIf config.modules.services.media.azuracast.enable {

    # Containers
    virtualisation.oci-containers.containers."azuracast" = {
      image = "ghcr.io/azuracast/azuracast:0.20.2";
      environment = {
        "APPLICATION_ENV" = "production";
        "AUTO_ASSIGN_PORT_MAX" = "8499";
        "AUTO_ASSIGN_PORT_MIN" = "8000";
        "COMPOSER_PLUGIN_MODE" = "false";
        "MYSQL_PASSWORD" = "CHANGE_ME";
        "MYSQL_RANDOM_ROOT_PASSWORD" = "yes";
        "SHOW_DETAILED_ERRORS" = "false";
      };
      volumes = [
        "/data/azuracast/web/acme:/var/azuracast/storage/acme:rw"
        "/data/azuracast/web/backups:/var/azuracast/backups:rw"
        "/data/azuracast/web/db_data:/var/lib/mysql:rw"
        "/data/azuracast/web/geolite_install:/var/azuracast/storage/geoip:rw"
        "/data/azuracast/web/metadata_cache:/var/azuracast/myMusic:rw"
        "/data/azuracast/web/sftpgo_data:/var/azuracast/storage/sftpgo:rw"
        "/data/azuracast/web/shoutcast2_install:/var/azuracast/storage/shoutcast2:rw"
        "/data/azuracast/web/station_data:/var/azuracast/stations:rw"
        "/data/azuracast/web/stereo_tool_install:/var/azuracast/storage/stereo_tool:rw"
        "/data/azuracast/web/www_uploads:/var/azuracast/storage/uploads:rw"
        "/mnt/raidrive/paki/Musica/Soundtracks/Giochi:/var/azuracast/myMusic/remote:ro"
      ];
      ports = [
        "880:80/tcp"
        "8843:443/tcp"
        "2022:2022/tcp"
        /*"8000:8000/tcp"
        "8005:8005/tcp"
        "8006:8006/tcp"
        "8010:8010/tcp"
        "8015:8015/tcp"
        "8016:8016/tcp"
        "8020:8020/tcp"
        "8025:8025/tcp"
        "8026:8026/tcp"
        "8030:8030/tcp"
        "8035:8035/tcp"
        "8036:8036/tcp"
        "8040:8040/tcp"
        "8045:8045/tcp"
        "8046:8046/tcp"
        "8050:8050/tcp"
        "8055:8055/tcp"
        "8056:8056/tcp"
        "8060:8060/tcp"
        "8065:8065/tcp"
        "8066:8066/tcp"
        "8070:8070/tcp"
        "8075:8075/tcp"
        "8076:8076/tcp"
        "8090:8090/tcp"
        "8095:8095/tcp"
        "8097:8096/tcp"
        "8100:8100/tcp"
        "8105:8105/tcp"
        "8106:8106/tcp"
        "8110:8110/tcp"
        "8115:8115/tcp"
        "8116:8116/tcp"
        "8120:8120/tcp"
        "8125:8125/tcp"
        "8126:8126/tcp"
        "8130:8130/tcp"
        "8135:8135/tcp"
        "8136:8136/tcp"
        "8140:8140/tcp"
        "8145:8145/tcp"
        "8146:8146/tcp"
        "8150:8150/tcp"
        "8155:8155/tcp"
        "8156:8156/tcp"
        "8160:8160/tcp"
        "8165:8165/tcp"
        "8166:8166/tcp"
        "8170:8170/tcp"
        "8175:8175/tcp"
        "8176:8176/tcp"
        "8180:8180/tcp"
        "8185:8185/tcp"
        "8186:8186/tcp"
        "8190:8190/tcp"
        "8195:8195/tcp"
        "8196:8196/tcp"
        "8200:8200/tcp"
        "8205:8205/tcp"
        "8206:8206/tcp"
        "8210:8210/tcp"
        "8215:8215/tcp"
        "8216:8216/tcp"
        "8220:8220/tcp"
        "8225:8225/tcp"
        "8226:8226/tcp"
        "8230:8230/tcp"
        "8235:8235/tcp"
        "8236:8236/tcp"
        "8240:8240/tcp"
        "8245:8245/tcp"
        "8246:8246/tcp"
        "8250:8250/tcp"
        "8255:8255/tcp"
        "8256:8256/tcp"
        "8260:8260/tcp"
        "8265:8265/tcp"
        "8266:8266/tcp"
        "8270:8270/tcp"
        "8275:8275/tcp"
        "8276:8276/tcp"
        "8280:8280/tcp"
        "8285:8285/tcp"
        "8286:8286/tcp"
        "8290:8290/tcp"
        "8295:8295/tcp"
        "8296:8296/tcp"
        "8300:8300/tcp"
        "8305:8305/tcp"
        "8306:8306/tcp"
        "8310:8310/tcp"
        "8315:8315/tcp"
        "8316:8316/tcp"
        "8320:8320/tcp"
        "8325:8325/tcp"
        "8326:8326/tcp"
        "8330:8330/tcp"
        "8335:8335/tcp"
        "8336:8336/tcp"
        "8340:8340/tcp"
        "8345:8345/tcp"
        "8346:8346/tcp"
        "8350:8350/tcp"
        "8355:8355/tcp"
        "8356:8356/tcp"
        "8360:8360/tcp"
        "8365:8365/tcp"
        "8366:8366/tcp"
        "8370:8370/tcp"
        "8375:8375/tcp"
        "8376:8376/tcp"
        "8380:8380/tcp"
        "8385:8385/tcp"
        "8386:8386/tcp"
        "8390:8390/tcp"
        "8395:8395/tcp"
        "8396:8396/tcp"
        "8400:8400/tcp"
        "8405:8405/tcp"
        "8406:8406/tcp"
        "8410:8410/tcp"
        "8415:8415/tcp"
        "8416:8416/tcp"
        "8420:8420/tcp"
        "8425:8425/tcp"
        "8426:8426/tcp"
        "8430:8430/tcp"
        "8435:8435/tcp"
        "8436:8436/tcp"
        "8440:8440/tcp"
        "8445:8445/tcp"
        "8446:8446/tcp"
        "8450:8450/tcp"
        "8455:8455/tcp"
        "8456:8456/tcp"
        "8460:8460/tcp"
        "8465:8465/tcp"
        "8466:8466/tcp"
        "8470:8470/tcp"
        "8475:8475/tcp"
        "8476:8476/tcp"
        "8480:8480/tcp"
        "8485:8485/tcp"
        "8486:8486/tcp"
        "8490:8490/tcp"
        "8495:8495/tcp"
        "8496:8496/tcp"*/
      ];
      labels = {
        "com.centurylinklabs.watchtower.scope" = "azuracast";
      };
      extraOptions = [
        "--log-opt=max-file=5"
        "--log-opt=max-size=1m"
        "--network-alias=web"
        "--network=azuracast_default"
      ];
    };
    systemd.services."podman-azuracast" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-azuracast_default.service"
      ];
      requires = [
        "podman-network-azuracast_default.service"
      ];
      partOf = [
        "podman-compose-azuracast-root.target"
      ];
      wantedBy = [
        "podman-compose-azuracast-root.target"
      ];
    };

    # Networks
    systemd.services."podman-network-azuracast_default" = {
      path = [ pkgs.podman ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStop = "podman network rm -f azuracast_default";
      };
      script = ''
        podman network inspect azuracast_default || podman network create azuracast_default
      '';
      partOf = [ "podman-compose-azuracast-root.target" ];
      wantedBy = [ "podman-compose-azuracast-root.target" ];
    };

    # Root service
    # When started, this will automatically create all resources and start
    # the containers. When stopped, this will teardown all resources.
    systemd.targets."podman-compose-azuracast-root" = {
      unitConfig = {
        Description = "Root target generated by compose2nix.";
      };
      wantedBy = [ "multi-user.target" ];
    };

  };
}