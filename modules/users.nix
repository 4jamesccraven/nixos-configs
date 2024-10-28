{ pkgs, ... }:

{
  ### Main account ###

  users.users.jamescraven = {
    isNormalUser = true;
    description = "James Craven";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  home-manager.users.jamescraven =
    { ... }:
    {
      home.stateVersion = "24.05";
    };

  users.users.fia = {
    isSystemUser = true;
    description = "fia";
    uid = 911;
    group = "fia";
    home = "/home/fia";
    shell = pkgs.bash;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];

    packages = with pkgs; [
      kitty
    ];
  };
  users.groups.fia = { };

  home-manager.users.fia =
    { ... }:
    {
      home.stateVersion = "24.05";
    };
}
