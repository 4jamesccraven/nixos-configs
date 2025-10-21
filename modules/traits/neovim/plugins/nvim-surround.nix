{ pkgs, ... }:

with pkgs.vimPlugins;
{
  plugin = nvim-surround;
  type = "lua";
  config = /* lua */ ''
    --> nvim-surround <--
    local surround = require'nvim-surround'

    -- Todo add custom surrounds, namely "Option<" ">" and "Result<" ">"

    surround.setup()
  '';
}
