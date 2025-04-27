{ pkgs, ... }:

with pkgs.vimPlugins;
[
  cmp-nvim-lsp
  cmp-buffer
  cmp-path
  cmp-cmdline
  cmp-nvim-ultisnips
  {
    plugin = nvim-cmp;
    type = "lua";
    config = # lua
      ''
        --> nvim-cmp <--
        local cmp = require'cmp'

        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.fn["UltiSnips#Anon"](args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert ({
                ['<CR>'] = cmp.mapping.select_next_item(),
                ['<tab>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources ({
                { name = 'nvim_lsp'},
                { name = 'buffer'},
                { name = 'path'},
                { name = 'ultisnips'},
            })
        })
      '';
  }
]
