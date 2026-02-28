{
  lib,
  config,
  modulesPath,
  ...
}:

{
  #[derive(Workstation)]
  imports = [
    ../modules/traits/workstation
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  networking.hostName = "celebrant";

  # use Graphical::Hyprland;
  hyprland.enable = true;
  home-manager.users.jamescraven = {
    wayland.windowManager.hyprland.settings = {
      monitor = [
        "eDP-1, 1920x1200, 0x0, 1.2"
      ];
    };
  };

  ### Hardware transcluded ###
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "usb_storage"
    "sd_mod"
    "sdhci_pci"
  ];

  boot.initrd.kernelModules = [
    "dm-snapshot"
    "cryptd"
  ];

  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-label/nixos";

  fileSystems."/" = {
    device = "/dev/disk/by-label/root";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/home";
    fsType = "ext4";
  };

  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
