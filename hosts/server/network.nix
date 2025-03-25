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

  /*services.ddns-updater = {
    enable = true;
    environment = {
      provider = "cloudflare";
      zone_identifier = "some id";
      domain = "pakisrv.com";
      ttl = "600";
      token = "${CF_API_KEY}";
      ip_version = "ipv4";
      ipv6_suffix = "";      
    };
  };*/

  # Tailscale VPN
  services.tailscale.enable = true;

}
