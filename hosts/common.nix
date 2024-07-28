{ pkgs, lib, config, inputs, ...}:

{
  imports = [
    inputs.home-manager.nixosModules.default
    ../modules
    ../myPackages
  ];

  gnome.enable = true; 

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.11";
}