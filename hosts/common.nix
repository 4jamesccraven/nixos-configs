{ inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
    ../modules
    ../overlay
  ];

  gnome.enable = true;
}
