{ pkgs, lib, config, ... }:

{

  home-manager.users.jamescraven = {
    programs.fastfetch = {
      enable = true;

      settings = {
        padding.top = 2;
        logo = {
          color = {
           "1" = "38;2;133;193;220";
           "2" = "38;2;202;158;230";
          };
        };


        display = {
          color = "38;2;202;158;230";
          separator = "  ";
          binaryPrefix = "si";
          temp = {
            unit = "C";
            ndigits = 0;
          };
          size = {
                  maxPrefix = "TB";
            ndigits = 2;
          };
          bar = {
                  charElapsed = "*";
            charTotal = " ";
          };
          percent = {
                  type = 1;
          };
        };


        modules = [
          "break"
          "break"

          {
            type = "title";
          }

          {
            type = "os";
            key = "├── ";
          }

          {
            type = "packages";
            key = "├── ";
          }

          {
            type = "theme";
            key = "├── ";
          }

          {
            type = "custom";
            key = "│";
            keyColor = "38;2;202;158;230";
          }

          {
            type = "datetime";
            key = "├── 󱑀";
            format = "{14}:{18}:{20}";
          }

          {
            type = "uptime";
            key = "├── 󰔛";
          }

          {
            type = "datetime";
            key = "├── ";
            format = "{3}/{11}/{1}";
          }

          {
            type = "custom";
            key = "│";
            keyColor = "38;2;202;158;230";
          }

          {
            type = "cpu";
            key = "├── ";
          }

                {
            type = "memory";
            key = "├── ";
          }

          {
            type = "gpu";
            key = "├── 󰡷";
          }

          {
            type = "disk";
            key = "├── ";
          }

          {
            type = "custom";
            key = "│";
            keyColor = "38;2;202;158;230";
          }

          {
                  type = "battery";
            key = "├── ";
          }

          {
                  type = "wifi";
            key = "├── ";
          }

          {
            type = "localip";
            key = "└── ";
          }
        ];
      };

    };
  };

}
