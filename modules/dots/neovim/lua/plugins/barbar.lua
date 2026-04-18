return {
    owner = 'romgrk',
    repo = 'barbar.nvim',
    deps = {
        { owner = 'nvim-tree', repo = 'nvim-web-devicons' },
    },
    config = function()
        require 'config.map' ('n', '<S-Tab>', ':BufferNext<CR>')
        require 'config.map' ('n', '<S-w>', ':BufferClose<CR>')
    end
}
