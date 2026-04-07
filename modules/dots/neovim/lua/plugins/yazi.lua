return function()
    ---[yazi-nvim]---
    local yz = require 'yazi'

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    yz.setup({
        open_for_directories = true,
    })

    require 'config.map' ('n', '<leader>t', function() yz.yazi() end)
end
