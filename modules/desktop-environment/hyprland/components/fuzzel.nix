{ config, ... }:

{

  home-manager.users.jamescraven =
    let
      base = "${config.colors.base.hex}ff";
      accent = "${config.colors.accent.hex}ff";
      text = "${config.colors.text.hex}ff";
    in
    {
      programs.fuzzel = {
        enable = true;

        settings = {
          main = {
            font = "FiraCode Nerd Font Mono:size=11";
            icon-theme = "Papirus-Dark";
          };
          border.width = 3;
          colors = {
            background = base;
            text = text;
            prompt = accent;

            match = text;
            border = accent;

            selection = accent;
            selection-match = base;
            selection-text = base;
          };
        };
      };
    };

}
