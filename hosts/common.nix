{ inputs, ...}:

{
  imports = [
    inputs.home-manager.nixosModules.default
    ../modules
    ../myPackages
  ];

  gnome.enable = true; 
}
