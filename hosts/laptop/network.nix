{ config, pkgs, ... }:

{
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  environment.systemPackages = with pkgs; [
    twingate  # Zero trust, richiede il servizio attivo
  ];

  services.twingate.enable = true;  # Abilita Twingate

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # Or disable the firewall altogether.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      80    # HTTP
      443   # HTTPS
    ];
    allowedTCPPortRanges = [ 
      { from = 30000; to = 31000; } # Twingate
    ];
    # allowedUDPPorts = [ ... ]:
    # allowedUDPPortRanges = [
    # ];
  };

}