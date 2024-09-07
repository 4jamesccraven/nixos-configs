{ ... }:

{
  home-manager.users.jamescraven = {

    programs.waybar = {
      enable = true;
      systemd.enable = true;

      style = ''
        window#waybar {
          background: transparent;
        }

        #window {
          transition: none;
          color: transparent;
          background: transparent;
        }

        #battery {
          margin-left: 5px;
          border-bottom: 2px solid rgb(202, 158, 230)
        }

        #bluetooth {
          margin-left: 5px;
          padding: 0px 5px;
          border-bottom: 2px solid rgb(202, 158, 230)
        }

        #clock {
          padding-left: 10px;
        }

        #custom-menu {
          margin: 0px 5px 0px 15px;
        }
         
        #custom-nix {
          padding: 10px;
        }

        #language {
          border-bottom: 2px solid rgb(202, 158, 230)
        }
        
        .modules-center {
          border-bottom: 2px solid rgb(202, 158, 230)
        }

        #network {
          margin-left: 10px;
          border-bottom: 2px solid rgb(202, 158, 230)
        }

        #pulseaudio-slider trough {
          min-width: 100px;
          border: none;
        }

        #pulseaudio-slider {
          margin-left: 5px;
          margin-right: 5px;
          padding-left: 5px;
          border-bottom: 2px solid rgb(202, 158, 230)
        }
      '';

      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 38;
          spacing = 6;

          modules-left = [
            "hyprland/workspaces"
          ];

          modules-center = [
            "clock"
            "custom/nix"
          ];

          modules-right = [
            "group/utils"
            "battery"
          ];

          ### Group ###
          "group/utils" = {
            orientation = "inherit";
            drawer = {
              click-to-reveal = true;
              transition-duration = 250;
              transition-left-to-right = false;
            };
            modules = [
              "custom/menu"
              "pulseaudio/slider"
              "hyprland/language"
              "network"
              "bluetooth"
            ];
          };

          ### Widget config ###
          battery = {
            format-icons = [ "" "" "" ];
            format-discharging = "{icon}    {capacity}%";
            format-charging = "󰂄    {capacity}%";
            interval = 1;
          };

          bluetooth = {
            format = "󰂯 ";
            on-click = "hyprctl dispatch exec [floating] blueman-manager";
          };

          clock = {
            interval = 1;
            tooltip-format = "{:%H:%M:%S    %a. %B %d, %Y}";
          };

          "custom/menu" = {
            format = "󰍜";
            tooltip = false;
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
            format-wifi = "󰖩 ";
            format-disconnected = "󰖪 ";
            format-ethernet = "󰈀 ";
            on-click = "hyprctl dispatch exec [floating] kitty nmtui connect";
          };
        };
      };
    };

  };
}
