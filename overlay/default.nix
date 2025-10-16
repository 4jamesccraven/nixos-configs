{ ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      dracula-cursors = prev.callPackage ./dracula-cursors.nix { };
      rff-script = prev.callPackage ./rff.nix { };
      update-notify = prev.callPackage ./update-notify.nix { };
      ns = prev.callPackage ./ns.nix { };
    })
  ];
}
