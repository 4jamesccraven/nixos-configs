{ config, lib, ... }:

{
  config = lib.mkIf config.hyprland.enable {
    home-manager.users.jamescraven =
      let
        colors = config.jcc.colors;
        base = "${colors.base.hex}ff";
        accent = "${colors.accent.hex}ff";
        text = "${colors.text.hex}ff";
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
  };
}
