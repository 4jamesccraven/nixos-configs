{ pkgs, ... }:

{
  users.users.jamescraven = {
    isNormalUser = true;
    description = "James Craven";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "libvirtd"
    ];
  };

  home-manager.users.jamescraven =
    { ... }:
    {
      home.stateVersion = "24.05";
    };
}
