{ ... }:

{
  home-manager.users.jamescraven = {

    programs.waybar = {
      enable = true;
      systemd.enable = true;

      style = ''
        #battery {
          padding-right: 5px;
        }

        #bluetooth {
          margin-left: 20px;
          margin-right: 10px;
        }

        #custom-nix {
          padding: 10px;
        }

        #language {
          padding: 0px;
        }

        #network {
          padding-left: 10px;
        }
      '';

      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;

          modules-left = [
            "network"
          ];

          modules-center = [
            "clock"
            "custom/nix"
          ];

          modules-right = [
            "hyprland/language"
            "bluetooth"
            "battery"
          ];

          ### Widget config ###
          battery = {
            format = "{icon}    {capacity}%";
            format-icons = [ "" "" "" ];
          };

          bluetooth = {
            format = "󰂯";
            on-click = "blueman-manager";
          };

          clock = {
            interval = 1;
            tooltip-format = "{:%H:%M:%S    %a. %B %d, %Y}";
          };

          "custom/nix" = {
            format = "󱄅";
            tooltip = false;
            on-click = "kitty ~/nixos";
          };

          "hyprland/language" = {
            format-en = "en";
            format-es = "es";

            on-click = "hyprctl switchxkblayout at-translated-set-2-keyboard next";
          };

          network = {
            format-wifi = "󰖩";
            format-disconnected = "󰖪";
            format-ethernet = "󰈀";
          };
        };
      };
    };

  };
}
