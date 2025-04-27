{ pkgs, ... }:

with pkgs.vimPlugins;
{
  plugin = nvim-surround;
  type = "lua";
  config = # lua
    ''
      --> nvim-surround <--
      require'nvim-surround'.setup()
    '';
}
