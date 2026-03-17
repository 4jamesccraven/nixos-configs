{ lib, inputs, ... }:

/*
  ====[ Overlay ]====

  Adds extra packages to `pkgs`.
*/
let
  inherit (lib.ext) overlayFromDir;
in
{
  nixpkgs.overlays = [
    # :> Local Overlay
    (overlayFromDir ./drv)

    # :> mkdev
    inputs.mkdev.overlays.default

    # :> etc
    (prev: _final: {
      ext.formatter = prev.callPackage ./formatter.nix { };
    })
  ];
}
