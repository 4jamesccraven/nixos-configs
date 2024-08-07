{ pkgs, ...}:

{

  # Language servers
  environment.systemPackages = with pkgs; [
    nixd
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
        telescope-nvim
        catppuccin-nvim
        coc-pyright
        coc-rust-analyzer
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
