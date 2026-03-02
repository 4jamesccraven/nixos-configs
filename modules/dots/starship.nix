{ lib, ... }:

/*
  ====[ Starship ]====
  :: dotfile

  Enables and configures starship, a shell prompt replacement.
*/
{
  home-manager.users.jamescraven = {
    programs.starship = {
      enable = true;

      settings = {
        add_newline = false;
        palette = "catppuccin-mocha";

        # ---[ General ]---
        format = lib.concatStrings [
          # :> user@host
          "$username"
          "[@](mauve)"
          "$hostname"
          ": $os"
          "$directory"

          # :> Informational Modules
          "$nix_shell"

          "$git_branch"
          "$git_status"
          "$git_metrics"

          "$rust"
          "$python"

          # :> Prompt
          "\n[=> ](mauve)"
        ];

        # ---[ Modules ]---
        # :> Identity
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

        # :> Location
        directory = {
          format = "[\\[](mauve)[$path]($style)[$read_only]($read_only_style)[\\]](mauve) ";
          style = "none";
          truncate_to_repo = false;
        };

        # :> Informational
        nix_shell = {
          format = "[\\(DevShell\\)]($style) ";
          heuristic = false;
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

        # ---[ Palette ]---
        palettes.catppuccin-mocha = {
          rosewater = "#f5e0dc";
          flamingo = "#f2cdcd";
          pink = "#f5c2e7";
          mauve = "#cba6f7";
          red = "#f38ba8";
          maroon = "#eba0ac";
          peach = "#fab387";
          yellow = "#f9e2af";
          green = "#a6e3a1";
          teal = "#94e2d5";
          sky = "#89dceb";
          sapphire = "#74c7ec";
          blue = "#89b4fa";
          lavender = "#b4befe";
          text = "#cdd6f4";
          subtext1 = "#bac2de";
          subtext0 = "#a6adc8";
          overlay2 = "#9399b2";
          overlay1 = "#7f849c";
          overlay0 = "#6c7086";
          surface2 = "#585b70";
          surface1 = "#45475a";
          surface0 = "#313244";
          base = "#1e1e2e";
          mantle = "#181825";
          crust = "#11111b";
        };
      };
    };
  };
}
