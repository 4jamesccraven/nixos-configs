return {
    owner = 'catppuccin',
    repo = 'nvim',
    config = function()
        require 'catppuccin'.setup({
            flavour = 'mocha',
            transparent_background = true,
            float = {
                transparent = true,
            },
        })

        vim.cmd.colorscheme 'catppuccin'
    end,
}
