{ config, pkgs, ... }:

{

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
      allowedTCPPorts = [ 80 443 ];
      # allowedUDPPorts = [ ... ];
    };

  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable Tailscale
  services.tailscale.enable = true;

}
