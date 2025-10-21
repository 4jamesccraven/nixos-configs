{ pkgs, ... }:

with pkgs.vimPlugins;
{
  plugin = barbar-nvim;
  type = "lua";
  config = /* lua */ ''
    --> barbar-nvim <--
    map('n', '<S-Tab>', ':BufferNext<CR>')
    map('n', '<S-w>', ':BufferClose<CR>')
  '';
}
