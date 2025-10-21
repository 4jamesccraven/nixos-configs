{ pkgs, ... }:

with pkgs.vimPlugins;
[
  {
    plugin = nvim-origami;
    type = "lua";
    config = /* lua */ ''
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
      require'origami'.setup({
          foldtext = {
              padding = 1,
              lineCount = {
                  template = ' %d',
              },
          }
      })
    '';
  }
  {
    plugin = statuscol-nvim;
    type = "lua";
    config = /* lua */ ''
      local builtin = require'statuscol.builtin'
      vim.opt.foldcolumn = '1'
      vim.opt.fillchars = {
          foldopen = '',
          foldclose = '',
          foldsep = ' ',
      }

      require'statuscol'.setup({
          setopt = true,
          segments = {
              {
                  text = { builtin.lnumfunc, ' ' },
                  condition = { true, builtin.not_empty },
                  click = "v:lua.ScLa",
              },
              { text = { builtin.foldfunc, ' ' }, click = 'v:lua.ScFa' },
          }
      })
    '';
  }
]
