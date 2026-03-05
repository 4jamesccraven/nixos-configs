{ libjcc, ... }:

/*
  ====[ Overlay ]====

  Adds extra packages to `pkgs`.
*/
let
  inherit (libjcc) overlayFromDir;
in
{
  nixpkgs.overlays = [
    (overlayFromDir ./drv)
  ];
}
