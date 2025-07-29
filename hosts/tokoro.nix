{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    ../modules/server.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  networking.hostName = "tokoro";

  services.borgbackup.jobs.main = {
    doInit = true;
    paths = [
      "/home/jamescraven/Code/"
      "/home/jamescraven/Documents/"
      "/home/jamescraven/Pictures/"
    ];
    encryption = {
      mode = "none";
    };
    repo = "/home/jamescraven/back-ups/";
    compression = "lz4";
    startAt = "daily";
  };

  ### Hardware transcluded ###
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ehci_pci"
    "ahci"
    "nvme"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/348657e2-5557-4ddc-a77f-3c22ac3e78f2";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/E951-BC80";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  fileSystems."/home/jamescraven/back-ups" = {
    device = "/dev/disk/by-uuid/2439b066-804d-43d5-b801-5c1f027e6c3e";
    fsType = "ext4";
  };

  fileSystems."/srv/media" = {
    device = "/dev/disk/by-uuid/b64d5484-d46d-4053-9bc0-8c8b81ac7184";
    fsType = "ext4";
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
