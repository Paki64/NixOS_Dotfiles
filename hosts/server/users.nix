{ pkgs, config, ... }:
#let
# passwordFile = config.sops.secrets.sys-passphrase.path;
#in
{
  users = {
    mutableUsers = true;
    users = {
      paki = {
        isNormalUser = true;
        description = "Pasquale Criscuolo";
        linger = true; #Enable lingering for services after logout
        extraGroups = [
          "docker"
          "input"
          "libvirtd"
          "networkmanager"
          "wheel"
        ];
        #shell = pkgs.zsh;
        #hashedPasswordFile = passwordFile;
      };
    };
  };
}