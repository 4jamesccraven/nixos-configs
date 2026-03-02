{ lib, ... }:

let
  inherit (lib) mkOption types;
in
{
  imports = [
    ./colors.nix
  ];

  options.jcc.flakeRoot = mkOption {
    type = types.path;
    description = "The path to the root of this flake";
  };

  config.jcc.flakeRoot = ../..;
}
