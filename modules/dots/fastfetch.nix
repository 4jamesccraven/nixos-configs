{ config, ... }:

/*
  ====[ Fastfetch ]====
  :: dotfile

  Enables and configures Fastfetch, a system information tool.
*/
{
  home-manager.users.jamescraven =
    let
      inherit (config.ext) colors flakeRoot;
      logo = flakeRoot + /assets/logo.txt;
      accent = colors.accent.ansi;
    in
    {
      programs.fastfetch = {
        enable = true;

        # ---[ Display Settings ]---
        settings = {
          logo.source = "${logo}";

          display = {
            bar = {
              border = {
                left = "[";
                right = "]";
              };
              char = {
                elapsed = "=";
                total = "-";
              };
            };

            color = {
              keys = "${accent}";
            };

            percent = {
              type = 3;
            };

            separator = " ";

            size = {
              binaryPrefix = "si";
              maxPrefix = "TB";
              ndigits = 2;
            };
          };

          modules = [
            {
              format = " /ˈiː.ən/{#keys}@{2}";
              type = "title";
            }
            {
              key = "╭───╮";
              type = "custom";
            }
            {
              key = "│ {#red} {#keys}│";
              format = "{name} {version-id}";
              type = "os";
            }
            {
              key = "│ {#red}󰪫 {#keys}│";
              format = "{type}";
              type = "chassis";
            }
            {
              key = "│ {#red} {#keys}│";
              format = "{pretty-name} {version}";
              type = "wm";
            }
            {
              key = "│ {#red} {#keys}│";
              format = "{pretty-name} {version}";
              type = "de";
            }
            {
              key = "│ {#red} {#keys}│";
              format = "{hour-pretty}:{minute-pretty}:{second-pretty}";
              type = "datetime";
            }
            {
              key = "├───┤";
              type = "custom";
            }
            {
              key = "│ {#green} {#keys}│";
              type = "shell";
            }
            {
              key = "│ {#green}󱩽 {#keys}│";
              type = "editor";
            }
            {
              key = "│ {#green}󰝚 {#keys}│";
              format = "{combined}";
              type = "media";
            }
            {
              key = "├───┤";
              type = "custom";
            }
            {
              key = "│ {#blue} {#keys}│";
              format = "{name}";
              type = "cpu";
            }
            {
              key = "│ {#blue} {#keys}│";
              format = "{vendor} {name}";
              type = "gpu";
            }
            {
              key = "│ {#blue} {#keys}│";
              format = "{percentage-bar} {total>10}";
              type = "memory";
            }
            {
              key = "│ {#blue} {#keys}│";
              format = "{size-percentage-bar} {size-total>10} {name}";
              type = "disk";
            }
            {
              key = "╰───╯";
              type = "custom";
            }
            {
              paddingLeft = 9;
              symbol = "diamond";
              type = "colors";
            }
          ];
        };
      };
    };

}
