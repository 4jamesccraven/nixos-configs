{ pkgs, ... }:

with pkgs.vimPlugins;
{
  plugin = alpha-nvim;
  type = "lua";
  config = # lua
    ''
      --> alpha-nvim <--
      local alpha = require'alpha'
      local dashboard = require'alpha.themes.dashboard'

      -- Define custom highlights
      dashboard.section.header = dofile('${../../../../assets/header.lua}')
      dashboard.section.buttons.val = {
          dashboard.button( 'n', ' New File', ':ene <BAR> startinsert <CR>' ),
          dashboard.button( 'f', '󰍉 Find Files', function() require'telescope.builtin'.find_files() end ),
          dashboard.button( 'g', ' Live Grep', function() require'telescope.builtin'.live_grep() end ),
          dashboard.button( 'N', ' Edit NixOS Configuration', function() require'telescope.builtin'.find_files({ cwd = '/home/jamescraven/nixos/' }) end ),
          dashboard.button( 'q', ' Quit', ':qa<CR>' ),
      }

      dashboard.config.layout = {
          { type = 'padding', val = 3 },
          dashboard.section.header,
          { type = 'padding', val = 3 },
          dashboard.section.buttons,
      }

      alpha.setup(dashboard.config)
    '';
}
