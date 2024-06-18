{ pkgs, lib, config, ...}:

{
  imports = [
    ./common.nix
  ];

  networking.hostName = "vaal";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}