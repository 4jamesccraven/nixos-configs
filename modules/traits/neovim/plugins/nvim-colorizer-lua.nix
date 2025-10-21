{ pkgs, ... }:

with pkgs.vimPlugins;
{
  plugin = nvim-colorizer-lua;
  type = "lua";
  config = /* lua */ ''
    --> nvim-colorizer-lua <--
    require'colorizer'.setup({ '*' }, {
        RGB = true,
        RRGGBB = true,
        RRGGBBAA = true,
        names = false,
        rgb_fn = true,
        hsl_fn = true,
    })
  '';
}
