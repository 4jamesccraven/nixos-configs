{
  pkgs,
  lib,
  config,
  modulesPath,
  ...
}:

{
  imports = [
    ./common.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  networking.hostName = "RioTinto";

  ## System-specific Packages ##
  environment.systemPackages = with pkgs; [
    heroic
    lutris
    piper
  ];
  services.hardware.openrgb.enable = true;
  services.ratbagd.enable = true;
  systemd.services.ratbagd.wantedBy = [
    "multi-user.target"
  ];
  hardware.xpadneo.enable = true;
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  hyprland.enable = true;

  home-manager.users.jamescraven = {
    wayland.windowManager.hyprland = {
      settings = {
        exec-once = [
          "openrgb -p main"
        ];

        monitor = [
          "DP-3, 2560x1080@75, 0x0, 1.0"
          "HDMI-A-1, 1920x1080, 320x-1080, 1.0"
        ];

        workspace = [
          "1, monitor:DP-3"
          "10, monitor:HDMI-A-1, persistent:true, default:true, on-created-empty:brave"
        ];
      };
    };
  };

  networking.firewall.trustedInterfaces = [ "virbr0" ];

  ## File System ##
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/2904deaf-0bd4-41a0-a791-ccf8f98035ae";
    fsType = "ext4";
  };

  fileSystems."/home/jamescraven/steam-nvme" = {
    device = "/steam";
    options = [ "bind" ];
  };

  ## Nvidia ##
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    graphics = {
      enable = true;
    };

    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      modesetting.enable = true;
      powerManagement = {
        enable = false;
        finegrained = false;
      };

      open = false;
      nvidiaSettings = true;
    };
  };

  ### Hardware transcluded ###
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/f0dd881a-edd3-4cd9-af89-4398a8fffaa9";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/EB06-9759";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp42s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
