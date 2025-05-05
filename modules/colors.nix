{ lib, ... }:

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
in
{
  options.colors = mkOption {
    type = types.attrsOf colorType;
    description = "Named colour variables";
  };

  config.colors = {
    base = {
      rgb = "30, 30, 46";
      hex = "1e1e2e";
      ansi = "38;2;30;30;46";
    };

    accent = {
      rgb = "203, 166, 247";
      hex = "cba6f7";
      ansi = "38;2;203;166;247";
    };

    text = {
      rgb = "205, 214, 244";
      hex = "cdd6f4";
      ansi = "38;2;205;214;244";
    };

    fail = {
      rgb = "243, 139, 168";
      hex = "#f38ba8";
      ansi = "38;2;243;139;168";
    };
  };
}
