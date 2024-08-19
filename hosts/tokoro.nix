{ config, lib, modulesPath, ... }:

{
  imports = [
    ../modules/server.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  networking.hostName = "tokoro";

  fileSystems."/home/jamescraven/back-ups" = {
    device = "/dev/disk/by-uuid/60d8bd49-3e3f-4415-8686-60571e867c65";
    fsType = "ext4";
  };

  services.borgbackup.jobs.syncthing-folders = {
    paths = [
      "/home/jamescraven/Code"
      "/home/jamescraven/Documents"
      "/home/jamescraven/Pictures"
    ];
    exclude = [ ".stfolder" ];
    repo = "/home/jamescraven/back-ups";
    encryption.mode = "none";
    compression = "zstd,22";
    startAt = "daily";
  };

  ### Hardware transcluded ###
  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/348657e2-5557-4ddc-a77f-3c22ac3e78f2";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/E951-BC80";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
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
