{ pkgs, ... }:

with pkgs.vimPlugins;
{
  plugin = (
    nvim-treesitter.withPlugins (p: [
      p.tree-sitter-bash
      p.tree-sitter-cmake
      p.tree-sitter-cpp
      p.tree-sitter-css
      p.tree-sitter-go
      p.tree-sitter-html
      p.tree-sitter-java
      p.tree-sitter-javascript
      p.tree-sitter-json
      p.tree-sitter-lua
      p.tree-sitter-markdown
      p.tree-sitter-nix
      p.tree-sitter-python
      p.tree-sitter-regex
      p.tree-sitter-rust
      p.tree-sitter-typst
      p.tree-sitter-yaml
    ])
  );
  type = "lua";
  config = # lua
    ''
      --> nvim-treesitter <--
      require('nvim-treesitter.configs').setup {
          ensure_installed = {},
          auto_install = false,
          highlight = { enable = true },
      }
    '';
}
