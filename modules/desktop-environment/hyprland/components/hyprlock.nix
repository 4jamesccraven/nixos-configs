{ config, lib, ... }:

{
  config = lib.mkIf config.hyprland.enable {
    home-manager.users.jamescraven =
      let
        base = "rgb(${config.colors.base.rgb})";
        accent = "rgb(${config.colors.accent.rgb})";
        text = "rgb(${config.colors.text.rgb})";
        red = "rgb(${config.colors.fail.rgb})";
      in
      {
        programs.hyprlock = {
          enable = true;

          settings = {
            background = {
              monitor = "";
              path = "${../../../../assets/wp-wide.png}";

              blur_passes = 2;
            };

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
                text = "cmd[update:1000] echo $(date '+%B %d')";
                font_size = 35;
                font_family = "FiraCode Nerd Font Mono";

                halign = "center";
                valign = "center";
                position = "0, 2%";

                color = text;
              }
            ];

            image = {
              monitor = "";
              path = "${../../../../assets/nixos-logo.png}";
              size = 80;

              halign = "center";
              valign = "bottom";

              border_color = accent;
            };

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
              fail_color = red;
            };
          };
        };
      };
  };
}
