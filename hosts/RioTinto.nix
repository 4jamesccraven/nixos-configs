{ pkgs, lib, config, ...}:

{
  imports = [
    ./common.nix
  ]

  networking.hostName = "RioTinto";
}