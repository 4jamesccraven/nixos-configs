{ lib, ... }:

{
  home-manager.users.jamescraven = {
    programs.starship = {
      enable = true;

      settings = {
        add_newline = false;
        palette = "catppuccin";

        format = lib.concatStrings [
          ### user@host ###
          #"[╭─\\(](mauve)"
          "$username"
          "[@](mauve)"
          "$hostname"
          # "[\\):󱄅 \\[](mauve)"
          ": $os"
          "$directory"

          ### Modules ###
          "$nix_shell"

          "$git_branch"
          "$git_status"
          "$git_metrics"

          "$rust"
          "$python"

          ### Prompt ###
          # "\n[╰─❯ ](mauve)"
          "\n[=> ](mauve)"
        ];

        username = {
          format = "[/ˈiː.ən/]($style)";
          style_user = "none";
          style_root = "none";
          show_always = true;
        };

        hostname = {
          ssh_only = false;
          format = "[$hostname]($style)";
          style = "mauve";
        };

        os = {
          disabled = false;
        };

        directory = {
          format = "[\\[](mauve)[$path]($style)[$read_only]($read_only_style)[\\]](mauve) ";
          style = "none";
          truncate_to_repo = false;
        };

        nix_shell = {
          format = "[\\(DevShell\\)]($style) ";
          heuristic = true;
        };

        git_branch = {
          style = "mauve";
        };

        git_status = {
          style = "bold mauve";
        };

        git_metrics = {
          format = "(\\([+$added]($added_style) [-$deleted]($deleted_style)\\) )";
          disabled = false;
        };

        rust = {
          format = "[$symbol $numver]($style) ";
          style = "bold red";
          symbol = "";
        };

        python = {
          format = "[$\{symbol} $\{version}( \\($\{virtualenv}\\))]($style) ";
          style = "bold blue";
          symbol = "";
        };

        ### Palette definition ###
        palettes.catppuccin = {
          rosewater = "#f2d5cf";
          flamingo = "#eebebe";
          pink = "#f4b8e4";
          mauve = "#ca9ee6";
          red = "#e78284";
          maroon = "#ea999c";
          peach = "#ef9f76";
          yellow = "#e5c890";
          green = "#a6d189";
          teal = "#81c8be";
          sky = "#99d1db";
          sapphire = "#85c1dc";
          blue = "#8caaee";
          lavender = "#babbf1";
          text = "#c6d0f5";
          subtext1 = "#b5bfe2";
          subtext0 = "#a5adce";
          overlay2 = "#949cbb";
          overlay1 = "#838ba7";
          overlay0 = "#737994";
          surface2 = "#626880";
          surface1 = "#51576d";
          surface0 = "#414559";
          base = "#303446";
          mantle = "#292c3c";
          crust = "#232634";
        };
      };
    };
  };
}
