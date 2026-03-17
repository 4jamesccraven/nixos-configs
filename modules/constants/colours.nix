{ lib, ... }:

/*
  ====[ Constants/colours ]====

  Some basic colours I use throughout my configuration.
*/
let
  inherit (lib) types mkOption;
  inherit (lib.ext) parseColour;

  colourType = types.submodule {
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

in
{
  options.ext.colours = mkOption {
    type = types.attrsOf colourType;
    description = "Named colour variables";
  };

  config.ext.colours =
    let
      colours = {
        # keep-sorted start
        accent = "cba6f7";
        base = "1e1e2e";
        fail = "f38ba8";
        mantle = "181825";
        text = "cdd6f4";
        # keep-sorted end
      };
    in
    builtins.mapAttrs (_: parseColour) colours;
}
