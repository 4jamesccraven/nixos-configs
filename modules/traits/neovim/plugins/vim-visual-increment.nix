{ pkgs, ... }:

with pkgs.vimPlugins;
{
  plugin = vim-visual-increment;
  type = "lua";
  config = # lua
    ''
      --> vim-visual-increment <--
      vim.cmd('set nrformats=alpha,octal,hex')
    '';
}
