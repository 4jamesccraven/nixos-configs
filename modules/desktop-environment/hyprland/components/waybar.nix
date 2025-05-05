{ config, ... }:

{
  home-manager.users.jamescraven = {

    programs.waybar = {
      enable = true;
      systemd.enable = true;

      style =
        with config.colors; # css
        ''
          @define-color base rgb(${base.rgb});
          @define-color acc  rgb(${accent.rgb});
          @define-color text rgb(${text.rgb});
          @define-color fail rgb(${fail.rgb});

          * {
            font-family: FiraCode Nerd Font Mono;
          }

          window#waybar {
            background: transparent;
          }

          window > box {
            background: @base;

            margin: 5px 20px;
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

          #custom-power {
            color: @acc;
          }

          #pulseaudio.muted {
            color: @fail;
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
            "image#nix"
          ];

          modules-right = [
            "privacy"
            "group/utils"
            "pulseaudio"
            "battery"
            "custom/power"
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
              "hyprland/language"
              "bluetooth"
              "network"
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
            format = "{:%b %d  %H:%M}";
            tooltip-format = "{:%H:%M:%S  %a. %B %d, %Y}\n\n{calendar}";
            calendar = {
              mode = "month";
              mode-mon-col = 3;
            };
            actions = {
              on-click = "mode";
            };
            interval = 1;
          };

          "custom/menu" = {
            format = "󰍜";
            tooltip = false;
          };

          "image#nix" = {
            path = "${../../../../assets/nixos-logo.png}";
            tooltip = false;
          };

          "custom/power" = {
            format = "⏻ ";
            tooltip = false;
            menu = "on-click";
            menu-file = "${./power-menu.xml}";
            menu-actions = {
              logout = "hyprctl dispatch exit";
              shutdown = "shutdown now";
              reboot = "reboot";
            };
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
            on-click = "hyprctl dispatch exec '[float; size 80%] kitty nmtui connect'";
            tooltip = false;
          };

          pulseaudio = {
            format = " {volume}%";
            format-muted = " {volume}%";
            scroll-step = 5;
          };
        };
      };
    };

  };
}
