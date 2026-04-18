local function exists(path)
    return vim.uv.fs_stat(path) ~= nil
end

return {
    owner = 'chomosuke',
    repo = 'typst-preview.nvim',
    config = function()
        local opts = {}

        local websocat_path = '/run/current-system/sw/bin/websocat'
        local tinymist_path = '/run/current-system/sw/bin/tinymist'

        if exists(websocat_path) and exists(tinymist_path) then
            opts.dependencies_bin = {
                websocat = websocat_path,
                tinymist = tinymist_path,
            }
        end

        require 'typst-preview'.setup(opts)
    end
}
