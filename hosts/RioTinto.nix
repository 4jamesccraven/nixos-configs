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

  ## Nvidia ##

  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
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

  services.hardware.openrgb.enable = true;
  
}
