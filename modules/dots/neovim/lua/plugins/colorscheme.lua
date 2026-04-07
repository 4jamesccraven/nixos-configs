return function()
    ---[catppuccin-nvim]---
    require 'catppuccin'.setup({
        flavour = 'mocha',
        transparent_background = true,
        float = {
            transparent = true,
        },
    })

    vim.cmd.colorscheme 'catppuccin'
end
