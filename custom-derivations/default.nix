{ ... }:

{
  # Custom Software override
  nixpkgs.config.packageOverrides = pkgs: {
    dracula-cursors = pkgs.callPackage ./dracula-cursors { };
  };
}
