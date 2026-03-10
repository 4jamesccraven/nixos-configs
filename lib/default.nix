modArgs:

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
    # keep-sorted start
    entriesIn
    genDirAttrs
    genFileAttrs
    mapDirs
    mapFileNames
    mapFileNames'
    mapFiles
    # keep-sorted end
    ;

  # :> Flake Helpers
  libFlake = importMod' ./libFlake.nix { inherit files; };
  inherit (libFlake)
    # keep-sorted start
    checksFromDir
    overlayFromDir
    shellsFromDir
    templatesFromDir
    # keep-sorted end
    ;

  # :> Colour Helpers
  colour = importMod ./colour.nix;
  inherit (colour)
    # keep-sorted start
    parseColor
    parseHex
    # keep-sorted end
    ;
}
