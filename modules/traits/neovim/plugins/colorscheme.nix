{ pkgs, ... }:

with pkgs.vimPlugins;
{
  plugin = catppuccin-nvim;
  type = "lua";
  config = /* lua */ ''
    --> catppuccin-nvim <--
    require'catppuccin'.setup({
      flavour = 'mocha',
      transparent_background = true,
      float = {
        transparent = true,
      },
    })

    vim.cmd.colorscheme 'catppuccin'
  '';
}
