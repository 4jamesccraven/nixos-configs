{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    nixd
    rust-analyzer
    clang-tools
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
        vim.opt.clipboard = 'unnamedplus'
        vim.opt.mouse = 'a'

        vim.opt.tabstop = 4
        vim.opt.softtabstop = 4
        vim.opt.shiftwidth = 4
        vim.opt.expandtab = true

        vim.opt.number = true
        vim.opt.relativenumber = true

        vim.opt.incsearch = true
        vim.opt.hlsearch = false
        vim.opt.ignorecase = true
        vim.opt.smartcase = true
      '';
    };
  };

}
