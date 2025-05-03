{ pkgs, ... }:

with pkgs.vimPlugins;
[
  cmp-nvim-lsp
  cmp-buffer
  cmp-path
  cmp-cmdline
  cmp_luasnip
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
                    require'luasnip'.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert ({
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<tab>'] = cmp.mapping.confirm({ select = true }),
                ['<CR>'] = cmp.mapping.abort(),
            }),
            sources = cmp.config.sources ({
                { name = 'buffer'},
                { name = 'luasnip' },
                { name = 'nvim_lsp'},
                { name = 'path'},
            })
        })
      '';
  }
]
