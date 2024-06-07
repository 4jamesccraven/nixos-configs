{ pkgs, lib, config, ...}:

{
  # Custom Software override
  nixpkgs.config.packageOverrides = pkgs: {
    mkdev = pkgs.callPackage ./mkdev { };
  };
}