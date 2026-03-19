{ config, lib, ... }:

/*
  ====[ Tealdeer ]====
  :: dotfile

  Enables and configure tealdeer, a client for tldr-pages.
*/
let
  inherit (lib.ext.colour) parseRGBString;
  inherit (config.ext.colours) accent;

  mauve = parseRGBString accent.rgb;
  accentCfg = {
    foreground.rgb = mauve;
  };
in
{
  home-manager.users.jamescraven = {
    programs.tealdeer = {
      enable = true;

      settings = {
        # :> General
        updates = {
          auto_update = true;
          auto_update_interval_hours = 720;
        };

        # :> Style
        style = lib.genAttrs [
          "command_name"
          "example_text"
          "example_code"
          "example_variable"
        ] (_: accentCfg);
      };
    };
  };
}
