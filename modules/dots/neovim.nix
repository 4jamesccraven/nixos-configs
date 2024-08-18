{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    nixd
    rust-analyzer
    clang-tools

    # Clipboard support
    xclip
  ];

  home-manager.users.jamescraven = {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;

      coc = {
        enable = true;

        settings = {
          "suggest.noselect" = true;
          "suggest.enablePreview" = true;
          "suggest.enablePreselect" = false;
          "suggest.disableKind" = true;
          "inlayHint.enable" = false;
  
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
        neo-tree-nvim
        telescope-nvim

        catppuccin-nvim

        coc-clangd
        coc-pyright
        coc-rust-analyzer
        coc-vimtex
      ];

      extraConfig = ''
        colorscheme catppuccin-frappe
      '';

      extraLuaConfig = ''
        -- Clipboard stuff (broken)
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
        vim.api.nvim_create_user_command('NT', 'Neotree', {})
        vim.cmd('cnoreabbrev nt NT')

        -- Open Neotree on launch
        vim.api.nvim_create_autocmd("VimEnter", {
          callback = function()
            vim.cmd("Neotree")
            vim.cmd("wincmd p")
          end
        })
      '';
    };
  };

}
