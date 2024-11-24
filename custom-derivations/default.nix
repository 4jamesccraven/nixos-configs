{ ... }:

{
  # Custom Software override
  nixpkgs.config.packageOverrides = pkgs: {
    dracula-cursors = pkgs.callPackage ./dracula-cursors { };
    rff-script = pkgs.callPackage ./rff { };
    nx = pkgs.callPackage ./nx { };
  };
}
