return function()
    ---[decisive-nvim]---
    -- Keybinds to enable the viewer
    require 'config.map' ('n', '<leader>cca', function() require 'decisive'.align_csv({}) end)
    require 'config.map' ('n', '<leader>ccA', function() require 'decisive'.align_csv_clear({}) end)
    require 'config.map' ('n', '[c', require 'decisive'.align_csv_prev_col)
    require 'config.map' ('n', ']c', require 'decisive'.align_csv_next_col)
end
