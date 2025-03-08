{ ... }:

{
  home-manager.users.jamescraven = {

    programs.waybar = {
      enable = true;
      systemd.enable = true;

      style = ''
        @define-color base rgb(48, 52, 70);
        @define-color acc  rgb(202, 158, 230);
        @define-color text rgb(198, 208, 245);

        * {
          font-family: FiraCode Nerd Font Mono;
        }

        window#waybar {
          background: transparent;
        }

        window > box {
          background: @base;

          margin: 20px;
          margin-bottom: 0px;
          padding: 5px;

          border: 3px solid @acc;
          border-radius: 10px;
        }

        #window {
          color: transparent;
          background: transparent;
        }

        tooltip {
          color: @text;
          background: @base;

          padding: 5px;

          border: 3px solid @acc;
          border-radius: 10px;
        }

        .module {
          color: @text;

          padding: 0 5px;
        }

        #network {
          padding: 8px;
        }

        #bluetooth {
          padding: 8px;
        }

        #custom-nix {
          color: @acc;

          font-size: 1.4em;
        }

        #workspaces button.active {
          color: @base;
          background: @acc;
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
            "privacy"
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
              "pulseaudio"
              "hyprland/language"
              "network"
              "bluetooth"
            ];
          };

          ### Widget config ###
          battery = {
            format-icons = [
              ""
              ""
              ""
            ];
            format-discharging = "{icon} {capacity}%";
            format-charging = "󰂄 {capacity}%";
            interval = 1;
          };

          bluetooth = {
            format = "󰂯";
            on-click = "hyprctl dispatch exec '[float; size 80%] blueman-manager'";
          };

          clock = {
            interval = 1;
            tooltip-format = "{:%H:%M:%S  %a. %B %d, %Y}\n\n{calendar}";
            calendar = {
              mode = "month";
              mode-mon-col = 3;
            };
            actions = {
              on-click = "mode";
            };
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
            format-wifi = "󰖩";
            format-disconnected = "󰖪";
            format-ethernet = "󰈀";
            on-click =  "hyprctl dispatch exec '[float; size 80%] kitty nmtui connect'";
            tooltip = false;
          };
        };
      };
    };

  };
}
