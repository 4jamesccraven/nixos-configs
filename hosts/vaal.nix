{ pkgs, lib, config, ...}:

{
  imports = [
    ./common.nix
  ];

  networking.hostName = "vaal";

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  ## System-specific Packages ##
  services.blueman.enable = true;
}