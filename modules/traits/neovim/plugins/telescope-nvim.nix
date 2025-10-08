{ pkgs, ... }:

with pkgs.vimPlugins;
{
  plugin = telescope-nvim;
  type = "lua";
  config = # lua
    ''
      --> telescope-nvim <--
      -- Keybinds
      map("n", "<leader>ff", require'telescope.builtin'.find_files)
      map("n", "<leader>fg", require'telescope.builtin'.live_grep)
      map("n", "<leader>fh", function()
          require'telescope.builtin'.find_files({ cwd = "~"})
      end)
    '';
}
