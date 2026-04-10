return function()
    ---[typst-preview-nvim]---
    require 'typst-preview'.setup {
        dependencies_bin = {
            websocat = '/run/current-system/sw/bin/websocat',
            tinymist = '/run/current-system/sw/bin/tinymist'
        },
    }
end
