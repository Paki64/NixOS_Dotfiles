{ config, pkgs, lib, inputs, ... }:

{

  imports = [ inputs.spicetify-nix.homeManagerModules.default ];
    
  programs.spicetify =
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in
  {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        powerBar
        phraseToPlaylist
        simpleBeautifulLyrics
    ];
  
    enabledCustomApps = with spicePkgs.apps; [
        newReleases
        ncsVisualizer
    ];
  
    enabledSnippets = with spicePkgs.snippets; [
        rotatingCoverart
        pointer
    ];

    theme = lib.mkDefault spicePkgs.themes.text;
    colorScheme = lib.mkDefault "nord";
  };

}