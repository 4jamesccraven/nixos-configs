{ lib, ... }:

/*
  ====[ lib/files ]====
  :: lib

  A collection of helpers for working with file structures.
*/
rec {
  # ---[ High Level Mapping Functions ]---

  # :> To lists

  /*
    mapFiles :: (string -> a) -> path -> [a]

    Equivalent to map, but the mapped functor is applied to the string names
    of all files in the provided directory.
    ```
    mapFiles (file: fromTOML (builtins.readFile file)) ./my-toml-files;
    ```
  */
  mapFiles = func: dir: map func (filesIn dir);

  /*
    mapDirs :: (string -> a) -> path -> [a]

    Equivalent to map, but the mapped functor is applied to the string names
    of all subdirectories in the provided directory.
  */
  mapDirs = func: dir: map func (dirsIn dir);

  /*
    mapFileNames :: (string -> a) -> path -> [a]

    Like mapFiles, but removes the ".nix" suffix automatically.
    ```
    mapFileNames (name: "${name}.toml") dir;
    ```
  */
  mapFileNames = func: dir: mapFileNames' func dir ".nix";

  /*
    mapFileNames' :: (string -> a) -> path -> string -> [a]

    Like mapFileNames, but allows extension to be stripped to be specified.
  */
  mapFileNames' =
    func: dir: suffix:
    map func (fileNamesIn' dir suffix);

  # :> To attrs

  /*
    genFileAttrs :: path -> (string -> a) -> { [string] :: a }

    Generates an attribute set by mapping a function over the names of files in
    a directory.
  */
  genFileAttrs = dir: func: lib.genAttrs (fileNamesIn dir) func;

  /*
    genDirAttrs :: path -> (string -> a) -> { [string] :: a }

    Generates an attribute set by mapping a function over the names of
    subdirectories in a directory.
  */
  genDirAttrs = dir: func: lib.genAttrs (dirsIn dir) func;

  # ---[ Typed Entries ]---

  # :> With suffix

  /*
    filesIn :: path -> [string]

    Gets the basenames of all files in a directory.
  */
  filesIn = dir: entriesIn' dir (t: t == "regular");

  /*
    directoriesIn :: path -> [string]

    Gets the basenames of all subdirectories in a directory.
  */
  dirsIn = dir: entriesIn' dir (t: t == "directory");

  # :> Without suffix
  /*
    fileNamesIn :: Path -> [string]

    Gets the basenames of all files in a directory, but without the ".nix"
    suffix.
  */
  fileNamesIn = dir: fileNamesIn' dir ".nix";

  /*
    fileNamesIn' :: path -> string -> [string]

    Like fileNamesIn, but allows specifying the suffix to strip.
  */
  fileNamesIn' = dir: suffix: mapFiles (lib.removeSuffix suffix) dir;

  # ---[ Entries Primitive ]---

  /*
    entriesIn :: path -> [string]

    Give a list of all entries in a directory.
  */
  entriesIn = dir: entriesIn' dir (_: true);

  /*
    entriesIn' :: path -> (string -> bool) -> [string]

    Like entriesIn but allows filtering on type. For more information on the
    types of entries, see https://noogle.dev/f/builtins/readDir.
    ```
    entriesIn' ./my-dir (t: t == "regular")
    ```
  */
  entriesIn' =
    dir: condition:
    lib.pipe dir [
      builtins.readDir
      (lib.filterAttrs (_: condition))
      builtins.attrNames
    ];
}
