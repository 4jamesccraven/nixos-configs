{
  config,
  inputs,
  libjcc,
  pkgs,
  lib,
  ...
}:

/*
  ====[ Any ]====
  :: trait

  Base type of all configurations.

  Enables:
    :> User level
    neovim       => I have to edit text on all systems
    jamescraven  => Essentially all config assumes the existence of my main account

    :> Config level
    constants    => Global constants to make config less verbose and error prone
    home-manager => All systems use home manager
    shell cache  => All systems should cache the dev-shells at build time
    nix-settings => All systems use flakes and nix command
*/
{
  imports = [
    inputs.home-manager.nixosModules.default
    ./neovim.nix
    ../constants
  ];

  # ---[ User account ]---
  users.users.jamescraven = {
    isNormalUser = true;
    description = "James Craven";
    shell = pkgs.zsh;
    extraGroups = [
      "jellyfin"
      "networkmanager"
      "wheel"
    ];
  };

  # ---[ DevShell Cache ]---
  system.activationScripts.cacheFlakeShells.text =
    let
      inherit (libjcc) mapFiles;
      inherit (config.jcc) flakeRoot;

      /*
        echoPkgs :: AttrSet -> string
        Creates a string which echos a package name into /dev/null.
      */
      echoPkg = pkg: "echo \"${pkg}\" > /dev/null";

      # Read in the build input of each devShell
      shellInputs = mapFiles (
        name:
        let
          params = (import ../../shells/${name} { inherit pkgs; });
        in
        params.buildInputs
      ) (flakeRoot + /shells);

      # Convert each set of inputs into a list of `echo` commands, then flatten
      cacheCommands = lib.concatMap (map echoPkg) shellInputs;
    in
    lib.concatLines cacheCommands;

  # ---[ Nix settings ]---
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "23.11";
  home-manager.users.jamescraven =
    { ... }:
    {
      home.stateVersion = "24.05";
    };
}
