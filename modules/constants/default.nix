{ lib, ... }:

/*
  ====[ Constants ]====

  Constants pertaining to my configuration
*/
let
  inherit (lib) mkOption types;
in
{
  imports = [
    ./colors.nix
    ./shell-aliases.nix
  ];

  options.jcc.flakeRoot = mkOption {
    type = types.path;
    description = "The path to the root of this flake";
  };

  config.jcc.flakeRoot = ../..;
}
