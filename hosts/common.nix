{ inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
    ../modules
    ../custom-derivations
  ];

  gnome.enable = true;
}
