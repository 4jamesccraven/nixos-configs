{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    nixd
    rust-analyzer
    clang-tools

    # Clipboard support
    xclip
    wl-clipboard
  ];

  home-manager.users.jamescraven = {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;

      withNodeJs = true;

      coc = {
        enable = true;

        settings = {
          "suggest.noselect" = true;
          "suggest.enablePreview" = true;
          "suggest.enablePreselect" = false;
          "suggest.disableKind" = true;
          "inlayHint.enable" = false;
          "python.analysis.autoImportCompletions" = false;
  
          languageserver = {
            nix = {
              command = "nixd";
              filetypes = [ "nix" ];
            };
          };
        };
      };

      # Plugins
      plugins = with pkgs.vimPlugins; [
        # Theme
        catppuccin-nvim

        # Utilities
        neo-tree-nvim
        telescope-nvim
        ultisnips
        vimtex

        # Language servers
        coc-clangd
        coc-pyright
        coc-rust-analyzer
        coc-ultisnips
        coc-vimtex
      ];

      extraConfig = ''
        " Enable catppuccin theme
        colorscheme catppuccin-frappe

        " Configure vimtex
        " general
        let g:vimtex_view_method = 'zathura'
        let g:vimtex_compiler_method = 'latexmk'
        let g:vimtex_compiler_latexmk = {'options' : ['-pdf',],}

        " text concealment
        set conceallevel=1
        let g:vimtex_conceal = 'abdmg'

        " Configure snippets
        let g:UltiSnipsSnippetDirectories=['/home/jamescraven/nixos/modules/dots/snippets']
        let g:UltiSnipsExpandTrigger = '<tab>'
        let g:UltiSnipsJumpForwardTrigger = '<tab>'
        let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
      '';

      extraLuaConfig = ''
        -- Clipboard stuff
        vim.opt.clipboard = 'unnamedplus'
        vim.opt.mouse = 'a'

        -- Tabs
        vim.opt.tabstop = 4
        vim.opt.softtabstop = 4
        vim.opt.shiftwidth = 4
        vim.opt.expandtab = true

        -- Line numbers
        vim.opt.number = true
        vim.opt.relativenumber = true

        -- Search config
        vim.opt.incsearch = true
        vim.opt.hlsearch = false
        vim.opt.ignorecase = true
        vim.opt.smartcase = true

        -- Rebind plugin commands
        vim.api.nvim_create_user_command('FF', 'Telescope find_files', {})
        vim.cmd('cnoreabbrev ff FF')
        vim.api.nvim_create_user_command('FG', 'Telescope live_grep', {})
        vim.cmd('cnoreabbrev fg FG')
        vim.api.nvim_create_user_command('NT', 'Neotree toggle', {})
        vim.cmd('cnoreabbrev nt NT')

        -- Transparent Background
        vim.cmd.highlight({ "Normal", "guibg=NONE", "ctermbg=NONE" })
        vim.cmd.highlight({ "NonText", "guibg=NONE", "ctermbg=NONE" })

        -- Neotree Config
        -- close if last open
        require("neo-tree").setup({
          close_if_last_window = true,
        })

        -- Launch configuration
        vim.api.nvim_create_autocmd("VimEnter", {
          callback = function()
            if vim.fn.argv(0) == "" then
              require("telescope.builtin").find_files()
              end
          end
        })

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
      '';
    };
  };

}
