{ pkgs, lib, config, ...}:

{
  imports = [
    <home-manager/nixos>
    ../hardware-configuration.nix
    ../modules
    ../myPackages
  ];

  gnome.enable = true; 

  system.stateVersion = "23.11";
}