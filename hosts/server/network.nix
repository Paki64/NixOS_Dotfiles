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
      allowedTCPPorts = [ 
        80          # HTTP 
        443         # HTTPS
        8384 22000  # Syncthing
      ]; 
      allowedUDPPorts = [ 
        22000 21027 # Syncthing
      ];
    };

  };

  # Enables the OpenSSH daemon.
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

  # Enables Samba
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "security" = "user";
        #"use sendfile" = "yes";
        #"max protocol" = "smb2";
        # note: localhost is the ipv6 localhost ::1
        #"hosts allow" = "192.168.0. 127.0.0.1 localhost";
        #"hosts allow" = "0.0.0.0/0"; # No whitelist due to remote tailscale-only connection        
        #"hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
      "NAS" = {
        "path" = "/media";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "paki";
        "force group" = "users";
      };
    };
  };

  # Samba advertisement for Windows
  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  # Tailscale VPN
  services.tailscale.enable = true;

}
