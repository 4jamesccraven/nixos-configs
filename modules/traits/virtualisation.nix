{ pkgs, lib, ... }:

/*
  ====[ Virtualisation ]====
  :: trait

  Settings to allow various forms of virtualisation.

  Enables:
    :> System Level
    libvirtd         => Traditional virtual machines
    docker/distrobox => containers/escape hatch
*/
{
  # ---[ Virtualisation ]---
  # :> libvirtd
  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "start";
      onShutdown = "shutdown";
      qemu.package = pkgs.qemu;
    };
    spiceUSBRedirection.enable = true;
  };
  # :> GUI for libvirtd
  programs.virt-manager.enable = true;

  # ---[ Containerisation ]---
  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
    distrobox
  ];

  # ---[ Group Management ]---
  # Make each user a member of each of `groups`.
  users.groups =
    let
      groups = [
        "docker"
        "libvirtd"
      ];
      users = [ "jamescraven" ];
    in
    lib.genAttrs groups (_: {
      members = users;
    });
}
