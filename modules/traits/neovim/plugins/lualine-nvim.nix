{ pkgs, ... }:

with pkgs.vimPlugins;
{
  plugin = lualine-nvim;
  type = "lua";
  config = # lua
    ''
      --> lualine-nvim <--
      require'lualine'.setup {
          sections = {
              lualine_a = { 'mode' },
              lualine_b = { 'branch', 'diagnostics' },
              lualine_c = { 'filename' },
              lualine_x = { 'filetype' },
              lualine_y = { 'lsp_status' },
              lualine_z = { 'selectioncount', 'location' }
          }
      }
    '';
}
