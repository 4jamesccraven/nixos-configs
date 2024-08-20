{...}:

{
  home-manager.users.jamescraven = {
    programs.fastfetch = {
      enable = true;

      settings = {
        logo = {
          source = "/home/jamescraven/nixos/assets/planet.txt";
          color = {
           "1" = "default";
           "2" = "38;2;202;158;230";
          };
        };

        display = {
          separator = "  ";
          size.binaryPrefix = "si";
          size = {
            maxPrefix = "TB";
            ndigits = 2;
          };
          bar = {
            charElapsed = "=";
            charTotal = "-";
            borderLeft = "[";
            borderRight = "]";
          };
          percent = {
            type = 1;
          };
          color = {
            keys = "38;2;202;158;230";
            output = "default";
          };
        };


        modules = [
          "break"
          {
            type = "custom";
            key = "《·───────────────·》◈《·──────────────·》";
            keyColor = "38;2;202;158;230";
          }
          {
            type = "os";
            key = "   OS ";
            format = "{2} {8}";
          }
          {
            type = "cpu";
            key = "   CPU";
            format = "{1}";
          }
          {
            type = "gpu";
            key = "   GPU";
            format = "{1} {2}";
          }
          {
            type = "memory";
            key = "   MEM";
            format = "{4} {3} (of {2})";
          }
          {
            type = "disk";
            key = "   DSK";
            format = "{13} {3} ({10})";
          }
          {
            type = "uptime";
            key = "   UP ";
            format = "{1}d {2}h {3}m {4}s";
          }
          {
            type = "datetime";
            key = "   NOW";
            format = "{14}:{18}:{20}, {3}/{11}/{2}";
          }
          {
            type = "custom";
            key = "《·───────────────·》◈《·──────────────·》";
            keyColor = "38;2;202;158;230";
          }
          {
            type = "colors";
            symbol = "diamond";
            paddingLeft = 14;
          }
        ];
      };

    };
  };

}
