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

      dividers = {
        top = {
          key = "╭───╮";
          type = "custom";
        };
        middle = {
          key = "├───┤";
          type = "custom";
        };

        bottom = {
          key = "╰───╯";
          type = "custom";
        };
      };

      /*
        args :: {
          type :: string,
          icon :: string,
          colour :: string,
          format :: string | null
        }
        mkModule :: args -> AttrSet

        Creates a fastfetch module config with a customised key containing a
        coloured icon.
      */
      mkModule =
        {
          type,
          icon,
          colour,
          format ? null,
        }:
        {
          inherit type;
          key = "│ {#${colour}}${icon} {#keys}│";
        }
        // (if format != null then { inherit format; } else { });

      /*
        mkColourGroup :: String -> AttrSet -> [AttrSet] -> [AttrSet]

        Prepends a divider to a list of modules, applying a shared colour to
        each.
      */
      mkColourGroup =
        colour: divider: modules:
        [ divider ] ++ map (m: mkModule (m // { inherit colour; })) modules;
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

            color.keys = "${accent}";
            percent.type = 3;
            separator = " ";

            size = {
              binaryPrefix = "si";
              maxPrefix = "TB";
              ndigits = 2;
            };
          };

          # ---[ Modules ]---
          modules = [
            {
              format = " /ˈiː.ən/{#keys}@{2}";
              type = "title";
            }
          ]
          ++ (mkColourGroup "red" dividers.top [
            {
              type = "os";
              icon = "";
              format = "{name} {version-id}";
            }
            {
              type = "chassis";
              icon = "󰪫";
              format = "{type}";
            }
            {
              type = "wm";
              icon = "";
              format = "{pretty-name} {version}";
            }
            {
              type = "de";
              icon = "";
              format = "{pretty-name} {version}";
            }
            {
              type = "datetime";
              icon = "";
              format = "{hour-pretty}:{minute-pretty}:{second-pretty}";
            }
          ])
          ++ (mkColourGroup "green" dividers.middle [
            {
              type = "shell";
              icon = "";
            }
            {
              type = "editor";
              icon = "󱩽";
            }
            {
              type = "media";
              icon = "󰝚";
              format = "{combined}";
            }
          ])
          ++ (mkColourGroup "blue" dividers.middle [
            {
              type = "cpu";
              icon = "";
              format = "{name}";
            }
            {
              type = "gpu";
              icon = "";
              format = "{vendor} {name}";
            }
            {
              type = "memory";
              icon = "";
              format = "{percentage-bar} {total>10}";
            }
            {
              type = "disk";
              icon = "";
              format = "{size-percentage-bar} {size-total>10} {name}";
            }
          ])
          ++ [
            dividers.bottom
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
