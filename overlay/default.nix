{ ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      ascii-view = prev.callPackage ./ascii-view.nix { };
      dracula-cursors = prev.callPackage ./dracula-cursors.nix { };
      ns = prev.callPackage ./ns.nix { };
      rff-script = prev.callPackage ./rff.nix { };
      update-notify = prev.callPackage ./update-notify.nix { };
    })
  ];
}
