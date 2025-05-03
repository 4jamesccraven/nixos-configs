{ pkgs, ... }:

with pkgs.vimPlugins;
let
  header = pkgs.stdenvNoCC.mkDerivation {
    name = "alpha-nvim-header";

    src = ../../../../assets/header.tar.gz;

    phases = [
      "unpackPhase"
      "installPhase"
    ];

    unpackPhase = ''
      tar xzf $src
    '';

    installPhase = ''
      mkdir -p $out
      cp header.lua $out
    '';
  };
in
{
  plugin = alpha-nvim;
  type = "lua";
  config = # lua
    ''
      --> alpha-nvim <--
      local alpha = require'alpha'
      local dashboard = require'alpha.themes.dashboard'

      -- Set header image
      dashboard.section.header = dofile('${header}/header.lua')

      -- Define functionality
      dashboard.section.buttons.val = {
          dashboard.button( 'n', ' New File', function()
              local Input = require'nui.input'
              local event = require'nui.utils.autocmd'.event

              local opts = {
                  position = '50%',
                  size = 25,
                  border = {
                      style = 'rounded',
                      text = {
                          top = 'File Name',
                      }
                  }
              }

              local input = Input(opts, {
                  prompt = " ",
                  on_submit = function(path)
                      if path == "" then
                          return
                      end

                      -- Expand relative paths
                      path = vim.fn.fnamemodify(path, ':p')

                      -- Create a new buf with the user's input
                      local buf = vim.api.nvim_create_buf(true, false)
                      vim.api.nvim_buf_set_name(buf, path)
                      vim.api.nvim_set_current_buf(buf)
                  end
              })

              input:map('i', '<Esc>', function()
                  input:unmount()
              end, { noremap = true })

              input:mount()

              input:on(event.BufLeave, function()
                  input:unmount()
              end)
          end),
          dashboard.button( 'f', '󰍉 Find Files', function() require'telescope.builtin'.find_files() end),
          dashboard.button( 'g', ' Live Grep', function() require'telescope.builtin'.live_grep() end),
          dashboard.button( 'N', ' Edit NixOS Configuration', function() require'telescope.builtin'.find_files({ cwd = '/home/jamescraven/nixos/' }) end),
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
