{ config, pkgs, ... }:

{
 
  # NixOS Network settings
  networking = {

    networkmanager.enable = true; # Enable networking
    hostName = "Paki-Server";   # Define your hostname.
    # wireless.enable = true;     # Enables wireless support via wpa_supplicant.

    interfaces.enp2s0 = {
      useDHCP = false;
      ipv4.addresses = [{
	      address = "192.168.1.101";
	      prefixLength = 24;
      }];
    };
	
    defaultGateway = "192.168.1.1";
    nameservers = [ "1.1.1.1" "192.168.1.101" ];

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    firewall = {
      enable = true;
      # allowedTCPPorts = [ 443 ]; 
      # allowedUDPPorts = [ ... ];
    };

  };



  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 10202 ];
    settings = {
      PasswordAuthentication = false;
      # AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };



  # Tailscale VPN
  services.tailscale.enable = true;



  # Traefik Reverse Proxy
  services.traefik = {
    enable = true;

    staticConfigOptions = {
      entryPoints = {
        
        web = {
          address = ":80";
          asDefault = true;
          http.redirections.entrypoint = {
            to = "websecure";
            scheme = "https";
          };
        };

        websecure = {
          address = ":443";
          asDefault = true;
          http.tls.certResolver = "letsencrypt";
          };
        };

        log = {
          level = "INFO";
          filePath = "${config.services.traefik.dataDir}/traefik.log";
          format = "json";
        };

        certificatesResolvers.letsencrypt.acme = {
          email = "postmaster@YOUR.DOMAIN";
          storage = "${config.services.traefik.dataDir}/acme.json";
          httpChallenge.entryPoint = "web";
        };

        api.dashboard = true; # Port 8080 
        #api.insecure = true;
      };

    dynamicConfigOptions = {
      http.routers = {};
      http.services = {};
    };    
  };

}
