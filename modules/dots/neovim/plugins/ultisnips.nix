{ pkgs, ... }:

with pkgs.vimPlugins;
{
  plugin = ultisnips;
  type = "lua";
  config = # lua
    ''
      --> ultisnips <--
      vim.g.UltiSnipsSnippetDirectories = {'/home/jamescraven/nixos/assets/snippets'}
      vim.g.UltiSnipsExpandTrigger = '<tab>'
      vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
      vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
    '';
}
