{ config, lib, ... }:

/*
  ====[ Hyprlock ]====
  :: In trait `Graphical`
  Config for hyprlock, a lock screen for hyprland.
*/
let
  inherit (config.jcc) flakeRoot;
  wpPath = flakeRoot + /assets/wp-wide.png;
  logoPath = flakeRoot + /assets/nixos-logo.png;
in
{
  config = lib.mkIf config.hyprland.enable {
    home-manager.users.jamescraven =
      let
        colors = config.jcc.colors;
        base = "rgb(${colors.base.rgb})";
        accent = "rgb(${colors.accent.rgb})";
        text = "rgb(${colors.text.rgb})";
        fail = "rgb(${colors.fail.rgb})";
      in
      {
        programs.hyprlock = {
          enable = true;

          settings = {
            # :> General
            background = {
              monitor = "";
              path = "${wpPath}";

              blur_passes = 2;
            };

            # ---[ Contents ]---
            # :> Time & Date
            label = [
              {
                monitor = "";
                text = "$TIME";
                font_size = 95;
                font_family = "FiraCode Nerd Font Mono";

                halign = "center";
                valign = "center";
                position = "0, 10%";

                color = text;
              }

              {
                monitor = "";
                text = "cmd[update:1000] echo $(date '+%a %B %d')";
                font_size = 25;
                font_family = "FiraCode Nerd Font Mono";

                halign = "center";
                valign = "center";
                position = "0, 2%";

                color = text;
              }
            ];

            # :> NixOS logo
            image = {
              monitor = "";
              path = "${logoPath}";
              size = 80;

              halign = "center";
              valign = "bottom";

              border_color = accent;
            };

            # :> Password Box
            input-field = {
              monitor = "";
              size = "10%, 4%";
              fade_on_empty = false;

              halign = "center";
              valign = "center";
              position = "0, -10%";

              outer_color = accent;
              inner_color = base;
              font_color = text;
              check_color = text;
              fail_color = fail;
            };
          };
        };
      };
  };
}
