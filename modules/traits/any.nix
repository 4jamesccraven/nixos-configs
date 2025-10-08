{
  inputs,
  pkgs,
  lib,
  ...
}:

# trait Any: Neovim + HomeManager {
#     /// Base type of all configurations
#     // User level
#     neovim       => I have to edit text on all systems;
#     jamescraven  => Essentially all config assumes the existence of my main account;
#
#     // Config level
#     constants    => Global constants to make config less verbose and error prone;
#     home-manager => All systems use home manager;
#     shell cache  => All systems should cache the dev-shells at build time;
#     nix-settings => All systems use flakes and nix command;
# }
{
  imports = [
    inputs.home-manager.nixosModules.default
    ./neovim
    ../constants
  ];

  # User account
  users.users.jamescraven = {
    isNormalUser = true;
    description = "James Craven";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "libvirtd"
      "seat"
    ];
  };

  #-> Cache DevShell Dependencies at Build Time <-#
  system.activationScripts.cacheFlakeShells.text = lib.concatLines (
    lib.flatten (
      map (
        name:
        let
          params = (import ../../shells/${name} { inherit pkgs; });
        in
        map (pkg: "echo \"${pkg}\" > /dev/null") params.buildInputs
      ) (builtins.attrNames (builtins.readDir ../../shells))
    )
  );

  # Nix settings
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
