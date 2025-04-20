{ ... }:

{
  programs.virt-manager.enable = true;

  users.groups.libvirtd.members = [
    "jamescraven"
  ];

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
    docker.enable = true;
    # vmware.host.enable = true;
  };
}
