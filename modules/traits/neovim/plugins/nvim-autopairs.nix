{ pkgs, ... }:

with pkgs.vimPlugins;
{
  plugin = nvim-autopairs;
  type = "lua";
  config = # lua
    ''
      --> nvim-autopairs <--
      require'nvim-autopairs'.setup()
    '';
}
