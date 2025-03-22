{ config, pkgs, ... }:

{

  networking = {

    networkmanager.enable = true; # Enable networking
    hostName = "Paki-Server01";   # Define your hostname.
    nameservers = [ "1.1.1.1" "192.168.1.101" ];
    # wireless.enable = true;     # Enables wireless support via wpa_supplicant.

    interfaces.enp2s0 = {
      useDHCP = false;
      ipv4.addresses = [{
	address = "192.168.1.101";
	prefixLength = 24;
      }];
    };

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    firewall = {
      enable = true;
      # allowedTCPPorts = [ ... ];
      # allowedUDPPorts = [ ... ];
    };

  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

}
