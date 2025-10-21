{ pkgs, ... }:

let
  decisive = pkgs.vimUtils.buildVimPlugin {
    name = "decisive-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "emmanueltouzery";
      repo = "decisive.nvim";
      rev = "c401541b8429b787d7dcb441e43bee63fc94737c";
      hash = "sha256-uy+Nj+hfeei8nquZCzIxDYf1eQsaPMX26IMh/opOwG0=";
    };

    meta.homepage = "https://github.com/emmanueltouzery/decisive.nvim";
  };
in
{
  plugin = decisive;
  type = "lua";
  config = /* lua */ ''
    --> decisive-nvim <--
    -- Keybinds to enable the viewer
    map('n', '<leader>cca', function() require'decisive'.align_csv({}) end)
    map('n', '<leader>ccA', function() require'decisive'.align_csv_clear({}) end)
    map('n', '[c', require'decisive'.align_csv_prev_col)
    map('n', ']c', require'decisive'.align_csv_next_col)
  '';
}
