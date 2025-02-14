{
  pkgs,
  config,
  ...
}:
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
        extraGroups = [
          "docker"
          "libvirtd"
          "input"
          "networkmanager"
          "wheel"
        ];
        #shell = pkgs.zsh;
        #hashedPasswordFile = passwordFile;
      };
    };
  };
}
