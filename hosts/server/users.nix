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
          "libvirtd"
          "input"
          "networkmanager"
          "wheel"
        ];
        password = "$(cat ${config.sops.secrets."hosts/server/users/paki/password".path})";
        #shell = pkgs.zsh;
        #hashedPasswordFile = passwordFile;
      };
    };
  };
}