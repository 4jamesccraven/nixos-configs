{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib) types mkOption;
in
{
  options.ext.term = {
    package = mkOption {
      description = "The package to be used as the terminal";
      type = types.package;
      example = ''
        pkgs.alacritty
      '';
    };

    bin = mkOption {
      description = "Path to the binary";
      type = types.str;
      default = lib.getExe config.ext.term.package;
    };

    runCmds = mkOption {
      description = "How to invoke the terminal with a specific program running";
      type = types.str;
      default = "${config.ext.term.bin}";
      example = ''
        "''${config.ext.term.bin} -e"
      '';
    };
  };

  config = {
    ext.term.package = pkgs.kitty;

    environment.variables = {
      TERMINAL = baseNameOf config.ext.term.bin;
    };
  };
}
