{
  inputs,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    inputs.nixos-wsl.nixosModules.default
    inputs.home-manager.nixosModules.default
    ../modules/wsl.nix
  ];

  networking.hostName = "wsl";

  wsl = {
    enable = true;
    defaultUser = "jamescraven";
    wslConf.network.hostname = "wsl";
  };

  users.users.jamescraven = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "James Craven";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  system.stateVersion = "24.05";

  ### Hardware transcluded ###
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/lib/modules/5.15.167.4-microsoft-standard-WSL2" = {
    device = "none";
    fsType = "overlay";
  };

  fileSystems."/mnt/wsl" = {
    device = "none";
    fsType = "tmpfs";
  };

  fileSystems."/usr/lib/wsl/drivers" = {
    device = "drivers";
    fsType = "9p";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/a423469d-f584-4f6b-97d5-b029ebde4d41";
    fsType = "ext4";
  };

  fileSystems."/mnt/wslg" = {
    device = "none";
    fsType = "tmpfs";
  };

  fileSystems."/mnt/wslg/distro" = {
    device = "none";
    fsType = "none";
    options = [ "bind" ];
  };

  fileSystems."/usr/lib/wsl/lib" = {
    device = "none";
    fsType = "overlay";
  };

  fileSystems."/tmp/.X11-unix" = {
    device = "/mnt/wslg/.X11-unix";
    fsType = "none";
    options = [ "bind" ];
  };

  fileSystems."/mnt/wslg/doc" = {
    device = "none";
    fsType = "overlay";
  };

  fileSystems."/mnt/c" = {
    device = "C:\134";
    fsType = "9p";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/b9448608-1edf-489f-b274-bd7660a6340c"; }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eth0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
