{ lib, files, ... }:

/*
  ====[ lib/libFlake ]====
  :: lib

  Helper functions for programmatically constructing flake outputs.
*/
let
  inherit (files) genFileAttrs genDirAttrs;
in
{

  /*
    shellsFromDir :: nixpkgs -> path -> attrsOf derivation

    Returns the value for the `devShell.${system}` attribute of a flake by
    reading AttrSets from each file in `dir` and treating them as the argument
    to `mkShell` (using the provided version of nixpkgs).
    ```
    let
      system = "x86_64-linux";
      pkgs = import <nixpkgs> { inherit system; };
    in
    {
      devShells.${system} = shellsFromDir pkgs ./shells;
    }
    ```
  */
  shellsFromDir =
    pkgs: dir:
    let
      mkDevShell =
        name:
        lib.pipe name [
          (name: import (dir + "/${name}.nix") { inherit pkgs; })
          pkgs.mkShell
        ];
    in
    genFileAttrs dir mkDevShell;

  /*
    checksFromDir :: { pkgs :: attrs; [String] :: a} -> path -> attrs

    Builds checks from a directory; takes in pkgs and any other values that may
    need to be passed through to the underlying derivation.
    ```
    checks.x86_64-linux = checksFromDir { inherit pkgs self; } ./checks;
    ```
  */
  checksFromDir =
    { pkgs, ... }@callPkgArgs:
    dir:
    let
      buildCheck = name: pkgs.callPackage (dir + "/${name}.nix") callPkgArgs;
    in
    genFileAttrs dir buildCheck;

  /*
    templatesFromDir :: path -> attrs

    Reads in templates from a given directory.
    ```
    {
      templates = templatesFromDir ./templates;
    }
    ```
  */
  templatesFromDir =
    dir:
    let
      genTemplate = name: {
        path = dir + "/${name}";
        description = if name != "default" then "Flake template for ${name}" else "Default template";
      };
    in
    genDirAttrs dir genTemplate;

  /*
    overlayFromDir :: path -> overlay

    Generates an overlay from a directory that contains packages.
  */
  overlayFromDir =
    dir:
    let
      mkPkg = prev: name: prev.callPackage (dir + "/${name}.nix") { };
    in
    (_final: prev: genFileAttrs dir (mkPkg prev));

}
