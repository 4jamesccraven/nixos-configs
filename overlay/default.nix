{ ... }:

/*
  ====[ Overlay ]====

  Adds extra packages to `pkgs`.
*/
{
  nixpkgs.overlays = [
    (final: prev: {
      ascii-view = prev.callPackage ./ascii-view.nix { };
      dracula-cursors = prev.callPackage ./dracula-cursors.nix { };
      ns = prev.callPackage ./ns.nix { };
      rff-script = prev.callPackage ./rff.nix { };
      screenie = prev.callPackage ./screenie.nix { };
      tor-dl = prev.callPackage ./tor-dl.nix { };
      update-notify = prev.callPackage ./update-notify.nix { };
    })
  ];
}
