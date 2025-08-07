{ config, ... }:

{
  home-manager.users.jamescraven = {
    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      extraConfig =
        let
          colors = config.colors;
          inherit (colors) base mantle text;
        in
        # lua
        ''
          local wezterm = require'wezterm'
          local config = wezterm.config_builder()

          -- Colour
          config.color_scheme = 'catppuccin-mocha'


          -- Cursor
          config.default_cursor_style = 'SteadyBar'
          config.cursor_thickness = '1px'

          -- Tab Bar
          config.use_fancy_tab_bar = false
          config.tab_bar_at_bottom = true
          config.hide_tab_bar_if_only_one_tab = true
          config.colors = {
              cursor_fg = '#${base.hex}',
              tab_bar = {
                  background = '#${base.hex}',
                  active_tab = {
                      bg_color = '#${mantle.hex}',
                      fg_color = '#${text.hex}',
                  },
                  inactive_tab = {
                      bg_color = '#${base.hex}',
                      fg_color = '#${text.hex}',
                  },
                  new_tab = {
                      bg_color = '#${base.hex}',
                      fg_color = '#${text.hex}',
                  },
                  inactive_tab_hover = {
                      bg_color = '#${base.hex}',
                      fg_color = '#${text.hex}',
                  },
                  new_tab_hover = {
                      bg_color = '#${base.hex}',
                      fg_color = '#${text.hex}',
                  },
              },
          }

          -- Font
          config.font_size = 12.0
          config.font = wezterm.font {
              family = 'FiraCode Nerd Font',
              harfbuzz_features = {
                  -- Change certain glyphs to alternate forms
                  "ss02", -- <= >=
                  "ss03", -- &
              }
          }

          -- Window
          config.window_decorations = 'NONE'
          config.window_background_opacity = 0.9
          config.window_padding = {
              left = 0,
              right = 0,
              top = 0,
              bottom = 0,
          }

          -- Graphics
          config.max_fps = 120

          return config
        '';
    };
  };
}
