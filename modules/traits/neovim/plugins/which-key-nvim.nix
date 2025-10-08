{ pkgs, ... }:

with pkgs.vimPlugins;
{
  plugin = which-key-nvim;
  type = "lua";
  config = # lua
    ''
      --> which-key-nvim <--
      local wk = require'which-key'
      wk.setup({
        plugins = {
            presets = {
                operators = false,
                motions = false,
                text_objects = false,
                windows = false,
                nav = false,
                z = false,
                g = false,
            },
        },
        triggers = {},
      })

      map('n', '<leader>?', function() wk.show() end, { desc = 'keybind help' })

      wk.add({
          { '<leader>vv', desc = 'Open a new tab to the right' },
          { '<leader>vs', desc = 'Open a new tab below' },
          { '<C-s>', desc = 'sort selected lines' },
          { '<leader>t', desc = 'toggle file panel' },
          { '<leader>t', desc = 'toggle file panel' },
          { '<leader>ff', desc = 'fuzzy find files in cwd' },
          { '<leader>fg', desc = 'grep files in cwd' },
          { '<leader>fh', desc = 'fuzzy find files in $HOME' },
          { '<S-Tab>', desc = 'go to the next buffer' },
          { '<S-w>', desc = 'close the active buffer' },
          { '<leader>d', desc = 'float error under cursor' },
          { '<leader>lk', desc = 'float lsp info' },
          { '<leader>lf', desc = 'go to code definition' },
          { '<leader>lr', desc = 'lsp replace' },
          { '<leader>ln', desc = 'go to next diagnostic' },
          { '<leader>lp', desc = 'go to previous diagnostic' },
          { '<leader>lb', desc = 'format the current buffer using the lsp' },
      })
    '';
}
