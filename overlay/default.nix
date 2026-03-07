{ lib, ... }:

/*
  ====[ Overlay ]====

  Adds extra packages to `pkgs`.
*/
let
  inherit (lib.ext) overlayFromDir;
in
{
  nixpkgs.overlays = [
    (overlayFromDir ./drv)
  ];
}
