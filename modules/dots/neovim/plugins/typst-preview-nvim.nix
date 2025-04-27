{ pkgs, ... }:

with pkgs.vimPlugins;
{
  plugin = typst-preview-nvim;
  type = "lua";
  config = # lua
    ''
      --> typst-preview-nvim <--
      require'typst-preview'.setup()
    '';
}
