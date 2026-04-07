return function()
    ---[nvim-treesitter]---
    require 'nvim-treesitter'.install { 'all' }
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function(event)
            local bufnr = event.buf
            local ft = vim.bo[bufnr].filetype
            local excluded = {
                csv = true, -- Decisive.nvim provides a better parser
            }
            -- -- no parser for ft or explicitly excluded
            if excluded[ft] then
                return
            end

            pcall(vim.treesitter.start)
            --
            -- local ok = pcall(vim.treesitter.get_parser, bufnr, ft)
            -- if ok then
            --     vim.treesitter.start(bufnr, ft)
            -- end
        end,
    })
end
