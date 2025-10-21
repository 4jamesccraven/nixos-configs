{ pkgs, ... }:

with pkgs.vimPlugins;
{
  plugin = indent-blankline-nvim;
  type = "lua";
  config = /* lua */ ''
    --> ibl <--
    require'ibl'.setup {
        scope = { enabled = false }
    }
  '';
}
