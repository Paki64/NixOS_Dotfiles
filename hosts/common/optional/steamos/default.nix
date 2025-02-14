{ lib, ... }:
{
  # Steam Jovian Config
  jovian = {
    hardware = {
      has.amd.gpu = true;
    };
    steam = {
      enable = true;
      autoStart = false; # Richiede disabilitato services.displayManager
      user = "paki";
      desktopSession = "plasma";
    };
  };

}
