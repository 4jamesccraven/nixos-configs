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

  ## File System Tweak ##
  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/807b6094-3680-4bb4-8c65-6451eca5aaee";
    fsType = "ext4";
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
