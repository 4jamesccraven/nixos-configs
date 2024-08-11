{ ... }:

{
  # Custom Software override
  nixpkgs.config.packageOverrides = pkgs: {
    mkdev = pkgs.callPackage ./mkdev { };
    dracula-cursors = pkgs.callPackage ./dracula-cursors { };
  };
}
