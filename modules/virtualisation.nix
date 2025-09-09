{ pkgs, ... }:

{
  programs.virt-manager.enable = true;

  users.groups.libvirtd.members = [
    "jamescraven"
  ];

  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "start";
      onShutdown = "shutdown";
      qemu.package = pkgs.qemu;
    };
    spiceUSBRedirection.enable = true;
    docker.enable = true;
  };

  environment.systemPackages = with pkgs; [
    distrobox
  ];
}
