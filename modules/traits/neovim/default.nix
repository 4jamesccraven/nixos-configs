{
  inputs,
  config,
  pkgs,
  lib,
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
        csharp-ls
        clang-tools
        nixd
        nixfmt-rfc-style
        pyright
        python313Packages.autopep8
        rust-analyzer
        rustfmt
        tinymist
        typstyle

        # Clipboard support
        xclip
        wl-clipboard
      ];

      enable = true;
      viAlias = true;
      vimAlias = true;

      defaultEditor = true;

      ### General config ###
      extraLuaConfig = /* lua */ ''
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
        vim.opt.splitright = true
        vim.opt.splitbelow = true

        -- Scrolling Offset
        vim.opt.scrolloff = 8
        vim.opt.sidescrolloff = 8

        -- Text Wrapping
        vim.opt.wrap = false

        -- Remember last place in buffer
        local lastplace = vim.api.nvim_create_augroup("LastPlace", {})
        vim.api.nvim_clear_autocmds({ group = lastplace })
        vim.api.nvim_create_autocmd("BufReadPost", {
            group = lastplace,
            pattern = { "*" },
            desc = "remember last cursor place",
            callback = function()
                if vim.fn.expand('%:t') == 'COMMIT_EDITMSG' then
                    return
                end

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
        map('n', '<leader>vv', ':vsplit<CR>')
        map('n', '<leader>vs', ':split<CR>')
        map('n', '<C-h>', '<C-w>h')
        map('n', '<C-j>', '<C-w>j')
        map('n', '<C-k>', '<C-w>k')
        map('n', '<C-l>', '<C-w>l')
        -- Sorting
        map('v', '<C-s>', ':sort<CR>')


        -->> Plugins <<--
      '';

      # Read import each plugin from plugins, and flatten the resulting list as
      # some plugins are grouped in a single file
      plugins = (
        lib.lists.flatten (
          inputs.utils.mapFiles (name: import ./plugins/${name} { inherit pkgs lib config; }) ./plugins
        )
      );

    };
  };

}
