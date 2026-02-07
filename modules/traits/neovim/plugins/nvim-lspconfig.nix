{ pkgs, ... }:

with pkgs.vimPlugins;
{
  plugin = nvim-lspconfig;
  type = "lua";
  config = /* lua */ ''
    --> nvim-lspconfig <--
    -- Servers
    vim.lsp.enable('csharp_ls')
    vim.lsp.enable('clangd')
    vim.lsp.enable('cmake')
    vim.lsp.enable('gopls')
    vim.lsp.enable('hls')
    vim.lsp.enable('jdtls')
    vim.lsp.enable('nixd')
    vim.lsp.config('nixd', {
        settings = {
            formatting = {
                command = { "nixfmt" },
            },
        }
    })
    vim.lsp.enable('pyright')
    vim.lsp.enable('rust_analyzer')
    vim.lsp.enable('r_language_server')
    vim.lsp.enable('sqls')
    vim.lsp.enable('tinymist')

    -- Keybinds
    map('n', '<leader>lk', function() vim.lsp.buf.hover()         end)
    map('n', '<leader>lf', function() vim.lsp.buf.definition()    end)
    map('n', '<leader>d' , function() vim.diagnostic.open_float() end)
    map('n', '<leader>lr', function() vim.lsp.buf.rename()        end)
    map('n', '<leader>ln', function() vim.diagnostic.goto_next()  end)
    map('n', '<leader>lp', function() vim.diagnostic.goto_prev()  end)
    map('n', '<leader>lb', function() vim.lsp.buf.format()        end)

    -- Autocommands
    vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            -- Format on save if supported
            if client.supports_method('textDocument/formatting') then
                vim.api.nvim_create_autocmd('BufWritePre', {
                    buffer = args.buf,
                    callback = function()
                        if not vim.tbl_contains({ "c", "cpp" }, vim.bo.filetype) then
                            vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                        end
                    end,
                })
            end
        end,
    })

    -- Fix for rust analyzer stuttering
    for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
        local default_diagnostic_handler = vim.lsp.handlers[method]
        vim.lsp.handlers[method] = function(err, result, context, config)
            if err ~= nil and err.code == -32802 then
                return
            end
            return default_diagnostic_handler(err, result, context, config)
        end
    end
  '';
}
