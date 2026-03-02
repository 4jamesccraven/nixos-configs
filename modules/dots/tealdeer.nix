{ ... }:

/*
  ====[ Tealdeer ]====
  :: dotfile

  Enables and configure tealdeer, a client for tldr-pages.
*/
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
        style = {
          command_name.foreground = {
            rgb = {
              r = 203;
              g = 166;
              b = 247;
            };
          };
          example_text.foreground = {
            rgb = {
              r = 203;
              g = 166;
              b = 247;
            };
          };
          example_code.foreground = {
            rgb = {
              r = 203;
              g = 166;
              b = 247;
            };
          };
          example_variable.foreground = {
            rgb = {
              r = 205;
              g = 214;
              b = 244;
            };
          };
        };
      };
    };
  };
}
