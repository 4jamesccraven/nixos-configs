{
  config,
  inputs,
  pkgs,
  ...
}:

{
  nix.nixPath = [
    "nixpkgs=${inputs.nixpkgs}"
  ];

  environment.sessionVariables.EDITOR = "nvim";

  home-manager.users.jamescraven = {
    programs.neovim = {

      extraPackages = with pkgs; [
        # LSP
        clang-tools
        haskell-language-server
        jdt-language-server
        nixd
        nixfmt-rfc-style
        rPackages.languageserver
        rPackages.languageserversetup
        ruff
        rust-analyzer
        rustfmt
        sqls
        texlab

        # Clipboard support
        xclip
        wl-clipboard
      ];

      enable = true;
      viAlias = true;
      vimAlias = true;

      defaultEditor = true;

      ### General config ###
      extraLuaConfig # lua
        = ''
          -- Leader Key
          vim.g.mapleader = ' '

          -- Clipboard
          vim.opt.clipboard = 'unnamedplus'

          -- Enable mouse
          vim.opt.mouse = 'a'

          -- Tabs
          vim.opt.tabstop = 4
          vim.opt.softtabstop = 4
          vim.opt.shiftwidth = 4
          vim.opt.expandtab = true
          vim.opt.list = true

          -- Line numbers
          vim.opt.number = true
          vim.opt.relativenumber = true

          -- Search Config
          vim.opt.incsearch = true
          vim.opt.hlsearch = false
          vim.opt.ignorecase = true
          vim.opt.smartcase = true

          -- Default Split Options
          vim.o.splitright = true
          vim.o.splitbelow = true

          -- Scrolling Offset
          vim.o.scrolloff = 8
          vim.o.sidescrolloff = 8

          -- Text Wrapping
          vim.o.wrap = false

          -- Remember last place in buffer
          local lastplace = vim.api.nvim_create_augroup("LastPlace", {})
          vim.api.nvim_clear_autocmds({ group = lastplace })
          vim.api.nvim_create_autocmd("BufReadPost", {
              group = lastplace,
              pattern = { "*" },
              desc = "remember last cursor place",
              callback = function()
                  local mark = vim.api.nvim_buf_get_mark(0, '"')
                  local lcount = vim.api.nvim_buf_line_count(0)
                  if mark[1] > 0 and mark[1] <= lcount then
                      pcall(vim.api.nvim_win_set_cursor, 0, mark)
                  end
              end,
          })

          -- Set tabsize for *.nix
          vim.cmd([[
              augroup NixTabSettings
                  autocmd!
                  autocmd FileType nix setlocal tabstop=2 shiftwidth=2 expandtab
              augroup END
          ]])

          -- Keybind function
          local function map(mode, lhs, rhs, opts)
              opts = opts or { noremap = true, silent = true }
              vim.keymap.set(mode, lhs, rhs, opts)
          end


          --> Keymap Configuration <--
          -- Split navigation
          map('n', '<leader>v', ':vsplit<CR>')
          map('n', '<leader>s', ':split<CR>')
          map('n', '<C-h>', '<C-w>h')
          map('n', '<C-j>', '<C-w>j')
          map('n', '<C-k>', '<C-w>k')
          map('n', '<C-l>', '<C-w>l')
          -- Sorting
          map('v', '<C-s>', ':sort<CR>')


          -->> Plugins <<--
        '';

      ### plugins ###
      plugins = with pkgs.vimPlugins; [
        {
          plugin = alpha-nvim;
          type = "lua";
          config = # lua
            ''
              --> alpha-nvim <--
              local alpha = require'alpha'
              local dashboard = require'alpha.themes.dashboard'

              -- Define custom highlights
              vim.api.nvim_set_hl(0, 'AlphaCatppuccinMauve', { fg = '#${config.colors.accent.hex}' })

              dashboard.section.header.val = {
                  [[ __  __               _____   ____       ]],
                  [[/\ \/\ \  __         /\  __`\/\  _`\     ]],
                  [[\ \ `\\ \/\_\   __  _\ \ \/\ \ \,\L\_\   ]],
                  [[ \ \ , ` \/\ \ /\ \/'\\ \ \ \ \/_\__ \   ]],
                  [[  \ \ \`\ \ \ \\/>  </ \ \ \_\ \/\ \L\ \ ]],
                  [[   \ \_\ \_\ \_\/\_/\_\ \ \_____\ `\____\]],
                  [[    \/_/\/_/\/_/\//\/_/  \/_____/\/_____/]],
              }
              dashboard.section.header.opts.hl = 'AlphaCatppuccinMauve'
              dashboard.section.buttons.val = {
                  dashboard.button( 'n', ' New File', ':ene <BAR> startinsert <CR>' ),
                  dashboard.button( 'f', '󰍉 Find Files', function() require'telescope.builtin'.find_files() end ),
                  dashboard.button( 'g', ' Live Grep', function() require'telescope.builtin'.live_grep() end ),
                  dashboard.button( 'N', ' Edit NixOS Configuration', function() require'telescope.builtin'.find_files({ cwd = '/home/jamescraven/nixos/' }) end ),
                  dashboard.button( 'q', ' Quit', ':qa<CR>' ),
              }

              dashboard.config.layout = {
                  { type = 'padding', val = 10 },
                  dashboard.section.header,
                  { type = 'padding', val = 3 },
                  dashboard.section.buttons,
              }

              alpha.setup(dashboard.config)
            '';
        }
        {
          plugin = barbar-nvim;
          type = "lua";
          config = # lua
            ''
              --> barbar-nvim <--
              map('n', '<C-Tab>', ':BufferNext<CR>')
              map('n', '<S-Tab>', ':BufferPrevious<CR>')
              map('n', '<S-w>', ':BufferClose<CR>')
            '';
        }
        {
          plugin = catppuccin-nvim;
          type = "lua";
          config = # lua
            ''
              --> catppuccin-nvim <--
              vim.cmd [[colorscheme catppuccin-mocha]]

              -- Transparent Background
              vim.cmd.highlight({ "Normal", "guibg=NONE", "ctermbg=NONE" })
              vim.cmd.highlight({ "NonText", "guibg=NONE", "ctermbg=NONE" })
            '';
        }
        {
          plugin = indent-blankline-nvim;
          type = "lua";
          config = # lua
            ''
              --> ibl <--
              require'ibl'.setup {
                  scope = { enabled = false }
              }
            '';
        }
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
                      ['<C-n>'] = cmp.mapping.select_next_item(),
                      ['<C-p>'] = cmp.mapping.select_prev_item(),
                      ['<Tab>'] = cmp.mapping.confirm({ select = true }),
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
        {
          plugin = lualine-nvim;
          type = "lua";
          config = # lua
            ''
              --> lualine-nvim <--
              require'lualine'.setup {
                  sections = {
                      lualine_a = { 'mode' },
                      lualine_b = { 'branch', 'diagnostics' },
                      lualine_c = { 'filename' },
                      lualine_x = { 'filetype' },
                      lualine_y = { 'lsp_status' },
                      lualine_z = { 'selectioncount', 'location' }
                  }
              }
            '';
        }
        markdown-preview-nvim
        {
          plugin = nvim-autopairs;
          type = "lua";
          config = # lua
            ''
              --> nvim-autopairs <--
              require'nvim-autopairs'.setup()
            '';
        }
        {
          plugin = nvim-lspconfig;
          type = "lua";
          config = # lua
            ''
              --> nvim-lspconfig <--
              require'lspconfig'.clangd.setup{}
              require'lspconfig'.hls.setup{}
              require'lspconfig'.jdtls.setup{}
              require'lspconfig'.nixd.setup{
                  settings = {
                      formatting = {
                          command = { "nixfmt" },
                      },
                  }
              }
              require'lspconfig'.ruff.setup{
                  settings = {
                      init_options = {
                          configuration = {
                              ["quote-style"] = "single",
                          },
                      }
                  }
              }
              require'lspconfig'.rust_analyzer.setup{}
              require'lspconfig'.r_language_server.setup{}
              require'lspconfig'.sqls.setup{}

              -- Keybind for diagnostic window
              map('n', '<leader>d', function()
                  vim.diagnostic.open_float(nil, { focusable = false })
              end)

              -- Autocommands
              vim.api.nvim_create_autocmd('LspAttach', {
                  callback = function(args)
                      local client = vim.lsp.get_client_by_id(args.data.client_id)
                      -- Format on save if supported
                      if client.supports_method('textDocument/formatting') then
                          vim.api.nvim_create_autocmd('BufWritePre', {
                              buffer = args.buf,
                              callback = function()
                                  vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                              end,
                          })
                      end
                  end,
              })

              -- Fix for rust analyzer stuttering
              for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
                  local default_diagnostic_handler = vim.lsp.handlers[method]
                  vim.lsp.handlers[method] = function(err, result, context, config)
                      if err ~= nil and err.code == -32802 then
                          return
                      end
                      return default_diagnostic_handler(err, result, context, config)
                  end
              end
            '';
        }
        {
          plugin = nvim-surround;
          type = "lua";
          config = # lua
            ''
              --> nvim-surround <--
              require'nvim-surround'.setup()
            '';
        }
        {
          plugin = nvim-tree-lua;
          type = "lua";
          config = # lua
            ''
              --> nvim-tree-lua <--
              -- Disable netrw
              vim.g.loaded_netrw = 1
              vim.g.loaded_netrwPlugin = 1

              require'nvim-tree'.setup({
                hijack_cursor = true,      -- keep the cursor fixed in file view
                disable_netrw = true,      -- really disable netrw
                sync_root_with_cwd = true, -- changes cwd of the tree with buffer
                sort = {
                  sorter = "extension",    -- Sort files by extensions
                },
                diagnostics = {
                  enable = true,           -- Enable diagnostics info
                },
                update_focused_file = {
                  enable = true,           -- Update tree based off of current file
                  update_root = true,      -- Change root if necessary
                }
              })
              map('n', '<leader>t', ':NvimTreeToggle<CR>')
            '';
        }
        nvim-web-devicons
        {
          plugin = telescope-nvim;
          type = "lua";
          config = # lua
            ''
              --> telescope-nvim <--
              -- Keybinds
              map("n", "<leader>f", require'telescope.builtin'.find_files)
              map("n", "<leader>g", require'telescope.builtin'.live_grep)
              map("n", "<leader>F", function()
                  require'telescope.builtin'.find_files({ cwd = "~"})
              end)
            '';
        }
        {
          plugin = (
            nvim-treesitter.withPlugins (p: [
              p.tree-sitter-bash
              p.tree-sitter-cpp
              p.tree-sitter-java
              p.tree-sitter-json
              p.tree-sitter-latex
              p.tree-sitter-lua
              p.tree-sitter-nix
              p.tree-sitter-python
              p.tree-sitter-rust
              p.tree-sitter-r
              p.tree-sitter-sql
              p.tree-sitter-vim
            ])
          );
          type = "lua";
          config = # lua
            ''
              --> nvim-treesitter <--
              require('nvim-treesitter.configs').setup {
                  ensure_installed = {},
                  auto_install = false,
                  highlight = { enable = true },
              }
            '';
        }
        {
          plugin = ultisnips;
          type = "lua";
          config = # lua
            ''
              --> ultisnips <--
              vim.g.UltiSnipsSnippetDirectories = {'/home/jamescraven/nixos/modules/dots/snippets'}
              vim.g.UltiSnipsExpandTrigger = '<tab>'
              vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
              vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
            '';
        }
        {
          plugin = vim-visual-increment;
          type = "lua";
          config = # lua
            ''
              --> vim-visual-increment <--
              vim.cmd('set nrformats=alpha,octal,hex')
            '';
        }

      ];

    };
  };

}
