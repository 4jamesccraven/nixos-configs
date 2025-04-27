{ pkgs, ... }:

with pkgs.vimPlugins;
{
  plugin = nvim-tree-lua;
  type = "lua";
  config = # lua
    ''
      --> nvim-tree-lua <--
      -- Disable netrw
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require'nvim-tree'.setup({
        hijack_cursor = true,      -- keep the cursor fixed in file view
        disable_netrw = true,      -- really disable netrw
        sync_root_with_cwd = true, -- changes cwd of the tree with buffer
        sort = {
          sorter = "extension",    -- Sort files by extensions
        },
        diagnostics = {
          enable = true,           -- Enable diagnostics info
        },
        update_focused_file = {
          enable = true,           -- Update tree based off of current file
          update_root = true,      -- Change root if necessary
        }
      })
      map('n', '<leader>t', ':NvimTreeToggle<CR>')
    '';
}
