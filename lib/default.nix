{ ... }@modArgs:

/*
  ====[ libext ]====
  :: lib

  A personal library of helper functions.
*/
let
  importMod = file: importMod' file { };
  importMod' = file: args: import file (modArgs // args);
in
rec {
  # :> File System Helpers
  files = importMod ./files.nix;
  inherit (files)
    mapFiles
    mapDirs
    mapFileNames
    mapFileNames'
    genFileAttrs
    genDirAttrs
    entriesIn
    ;

  # :> Flake Helpers
  libFlake = importMod' ./libFlake.nix { inherit files; };
  inherit (libFlake)
    shellsFromDir
    checksFromDir
    templatesFromDir
    overlayFromDir
    ;

  # :> Colour Helpers
  colour = importMod ./colour.nix;
  inherit (colour)
    parseColor
    parseHex
    ;
}
