{ lib, ... }:

/*
  ====[ Constants/colours ]====

  Some basic colours I use throughout my configuration, and utilities to
  convert them to other types.

  TODO: move parseColor to utils
*/
with lib;
let
  colorType = types.submodule {
    options = {
      rgb = mkOption {
        type = types.str;
      };

      hex = mkOption {
        type = types.str;
      };

      ansi = mkOption {
        type = types.str;
      };
    };
  };

  /*
    parseColor :: string -> colorType

    Takes a hexadecimal colour string with or without the leading #
    and converts it to a colorType module.
  */
  parseColor =
    hex:
    let
      hexNoPrefix = removePrefix "#" hex;
      channels = {
        r = 1;
        g = 2;
        b = 3;
      };

      /*
        hexPairOf :: int -> string
        maps {1,2,3} to the hex associated with {r,g,b}, respectively.
      */
      hexPairOf = n: builtins.substring ((n - 1) * 2) 2 hexNoPrefix;
      /*
        defineAsToml :: string -> int -> string
        takes the name of a channel (in {r,g,b}) and a hex value and converts
        it to an equivalent TOML mapping.
      */
      defineAsTOML = channel: index: "${channel} = 0x${hexPairOf index}";

      # Create the TOML document
      tomlAttrs = lib.mapAttrsToList defineAsTOML channels;
      tomlDoc = lib.concatLines tomlAttrs;
      # Parse and convert ints to strings
      rgb = builtins.mapAttrs (_: toString) (fromTOML tomlDoc);
    in
    {
      hex = hexNoPrefix;
      rgb = "${rgb.r}, ${rgb.g}, ${rgb.b}";
      ansi = "38;2;${rgb.r};${rgb.g};${rgb.b}";
    };
in
{
  options.jcc.colors = mkOption {
    type = types.attrsOf colorType;
    description = "Named colour variables";
  };

  config.jcc.colors =
    let
      colours = {
        base = "1e1e2e";
        accent = "cba6f7";
        text = "cdd6f4";
        fail = "f38ba8";
        mantle = "181825";
      };
    in
    builtins.mapAttrs (_: parseColor) colours;
}
