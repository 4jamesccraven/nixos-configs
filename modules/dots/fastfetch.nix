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
            # :> Percent Bars
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

            # :> Colours
            color = {
              keys = accent;
              output = "default";
            };
            # :> Constant Strings
            constants = [
              "══════════════════════════════════════"
              "                                      "
              "[38D"
            ];
            percent.type = 3;
            # :> Disable Default Separator
            separator = "";
            # :> Data Size Formatting
            size = {
              binaryPrefix = "si";
              maxPrefix = "TB";
              ndigits = 2;
            };
          };

          # ---[ Information Modules ]---
          modules = [
            {
              format = " /ˈiː.ən/{#keys}@{2}";
              type = "title";
            }
            {
              key = "╔═══╦{$1}╗";
              type = "custom";
            }
            {
              format = "{2} {9}";
              key = "║ {#red} {#keys}║{$2}║{$3}";
              type = "os";
            }
            {
              format = "{1}";
              key = "║ {#red}󰪫 {#keys}║{$2}║{$3}";
              type = "chassis";
            }
            {
              format = "{2} {3}";
              key = "║ {#red} {#keys}║{$2}║{$3}";
              type = "de";
            }
            {
              format = "{2} {5}";
              key = "║ {#red} {#keys}║{$2}║{$3}";
              type = "wm";
            }
            {
              format = "{14}:{18}:{20}";
              key = "║ {#red} {#keys}║{$2}║{$3}";
              type = "datetime";
            }
            {
              key = "╠═══╬{$1}╣";
              type = "custom";
            }
            {
              key = "║ {#green} {#keys}║{$2}║{$3}";
              type = "shell";
            }
            {
              key = "║ {#green}󱩽 {#keys}║{$2}║{$3}";
              type = "editor";
            }
            {
              format = "{1}";
              key = "║ {#green}󰝚 {#keys}║{$2}║{$3}";
              type = "media";
            }
            {
              key = "╠═══╬{$1}╣";
              type = "custom";
            }
            {
              format = "{1}";
              key = "║ {#blue} {#keys}║{$2}║{$3}";
              type = "cpu";
            }
            {
              format = "{2}";
              key = "║ {#blue} {#keys}║{$2}║{$3}";
              type = "gpu";
            }
            {
              format = "{4} {2}";
              key = "║ {#blue} {#keys}║{$2}║{$3}";
              type = "memory";
            }
            {
              format = "{13} {2} {10}";
              key = "║ {#blue} {#keys}║{$2}║{$3}";
              type = "disk";
            }
            {
              key = "╚═══╩{$1}╝";
              type = "custom";
            }
            {
              paddingLeft = 14;
              symbol = "diamond";
              type = "colors";
            }
          ];
        };

      };
    };

}
