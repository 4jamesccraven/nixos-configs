{ pkgs, ... }:

with pkgs.vimPlugins;
{
  plugin = yazi-nvim;
  type = "lua";
  config = /* lua */ ''
    --> yazi-nvim <--
    local yz = require'yazi'

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    yz.setup({
      open_for_directories = true,
    })

    map('n', '<leader>t', function() yz.yazi() end)
  '';
}
