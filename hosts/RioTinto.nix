{ pkgs, lib, config, ...}:

{
  imports = [
    ./common.nix
  ];

  networking.hostName = "RioTinto";

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    supportedFilesystems = [ "ntfs" ];
  };

  ## System-specific Packages ##

  environment.systemPackages = with pkgs; [
    heroic
  ];
  services.hardware.openrgb.enable = true;

  ## Nvidia ##

  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    graphics = {
      enable = true;
    };


    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      
      open = false;
      nvidiaSettings = true;
    };
  };
}
