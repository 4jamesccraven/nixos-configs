{ pkgs, ... }:

with pkgs.vimPlugins;
{
  plugin = yazi-nvim;
  type = "lua";
  config = # lua
    ''
      --> yazi-nvim <--
      map('n', '<leader>t', function() require'yazi'.yazi() end)
    '';
}
