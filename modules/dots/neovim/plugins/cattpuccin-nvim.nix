{ pkgs, ... }:

with pkgs.vimPlugins;
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
