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

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
