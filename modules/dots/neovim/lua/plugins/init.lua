local M = {}

local function to_lazy(t)
    local result = {}
    for i, v in ipairs(t) do
        result[i] = 'https://github.com/' .. v
    end
    return result
end

local function require_all(dir)
    local scan = vim.loop.fs_scandir(dir)
    if not scan then return end

    while true do
        local name, fs_type = vim.loop.fs_scandir_next(scan)
        if not name then break end

        if fs_type == 'file' and name:match("%.lua$") and name ~= "init.lua" then
            local module = 'plugins.' .. name:gsub("%.lua$", '')
            local ok, conf = pcall(require, module)
            if not ok then
                vim.notify(
                    'failed to load plugin config: ' .. module .. '\n' .. conf,
                    vim.log.levels.ERROR
                )
            elseif type(conf) == 'function' then
                local success, err = pcall(conf)
                if not success then
                    vim.notify(
                        'Error in ' .. module .. '\n' .. err,
                        vim.log.levels.ERROR
                    )
                end
            end
        end
    end
end

vim.pack.add(to_lazy {
    'romgrk/barbar.nvim',
    'catppuccin/nvim',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'lukas-reineke/indent-blankline.nvim',
    'nvim-lualine/lualine.nvim',
    'L3MON4D3/LuaSnip',
    'iamcco/markdown-preview.nvim',
    'nvim-lua/plenary.nvim',
    'windwp/nvim-autopairs',
    'hrsh7th/nvim-cmp',
    'neovim/nvim-lspconfig',
    'kylechui/nvim-surround',
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
    'MeanderingProgrammer/render-markdown.nvim',
    'nvim-telescope/telescope.nvim',
    'chomosuke/typst-preview.nvim',
    'emmanueltouzery/decisive.nvim',
    'triglav/vim-visual-increment',
    'folke/which-key.nvim',
    'mikavilpas/yazi.nvim',
})

require_all(vim.fn.stdpath('config') .. '/lua/plugins')

return M
