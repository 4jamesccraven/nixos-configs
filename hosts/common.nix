{ pkgs, lib, config, inputs, ...}:

{
  imports = [
    inputs.home-manager.nixosModules.default
    ../hardware-configuration.nix
    ../modules
    ../myPackages
  ];

  gnome.enable = true; 

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.11";
}