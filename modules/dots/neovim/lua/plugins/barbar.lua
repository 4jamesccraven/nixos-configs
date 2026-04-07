return function()
    ---[barbar-nvim]---
    require 'config.map' ('n', '<S-Tab>', ':BufferNext<CR>')
    require 'config.map' ('n', '<S-w>', ':BufferClose<CR>')
end
