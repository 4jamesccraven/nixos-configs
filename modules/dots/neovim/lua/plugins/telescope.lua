return {
    owner = 'nvim-telescope',
    repo = 'telescope.nvim',
    deps = {
        { owner = 'nvim-lua', repo = 'plenary.nvim' },
    },
    config = function()
        local map = require 'config.map'
        -- Keybinds
        map("n", "<leader>ff", require 'telescope.builtin'.find_files)
        map("n", "<leader>fg", require 'telescope.builtin'.live_grep)
        map("n", "<leader>fh", function()
            require 'telescope.builtin'.find_files({ cwd = "~" })
        end)
    end
}
