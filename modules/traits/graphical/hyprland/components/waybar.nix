{
  config,
  pkgs,
  lib,
  ...
}:

{
  config = lib.mkIf config.hyprland.enable {
    home-manager.users.jamescraven = {

      programs.waybar = {
        enable = true;
        systemd.enable = true;

        style = with config.colors; /* css */ ''
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

          #audio, #sys, #utils {
            padding: 0 5px;
            border: 2px solid @acc;
            border-radius: 8px;
          }

          #bluetooth, #network {
            color: @acc;
            padding: 8px;
          }

          #custom-nix,
          #custom-power,
          #custom-repo {
            color: @acc;
          }

          #custom-menu {
            color: rgb(127, 132, 156);
          }

          #custom-update.ok {
            color: rgb(127, 132, 156);
          }
          #custom-update.warn {
            color: @acc;
          }
          #custom-update.late {
            color: @fail;
          }

          #custom-menu,
          #custom-nix,
          #custom-power,
          #custom-update,
          #custom-repo {
            font-size: 1.4em;
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
              "custom/update"
              "custom/repo"
            ];

            modules-right = [
              "group/utils"
              "group/audio"
              "group/sys"
            ];

            ### Group ###
            "group/audio" = {
              orientation = "inherit";
              modules = [
                "privacy"
                "pulseaudio"
              ];
            };

            "group/sys" = {
              orientation = "inherit";
              modules = [
                "battery"
                "custom/power"
              ];
            };

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
              # I know this is atrocious but I can't separate it or it doesn't work for some reason.
              tooltip-format = "<b>{:%H:%M:%S  %a. %B %d, %Y}</b>\n󰍽 M2: Reset | <span size=\"x-large\">󱕒</span> : Next/Previous\n\n{calendar}";
              calendar = {
                mode = "month";
                mode-mon-col = 3;
                format = with config.colors; {
                  months = "<span color=\"#${accent.hex}\"><b>{}</b></span>";
                  weekdays = "<b>{}</b>";
                  today = "<span color=\"#${accent.hex}\"><b><u>{}</u></b></span>";
                };
              };
              actions = {
                on-click = "mode";
                on-click-right = "shift_reset";
                on-scroll-down = "shift_up";
                on-scroll-up = "shift_down";
              };
              interval = 1;
            };

            "custom/menu" = {
              format = "󰍜";
              tooltip = false;
            };

            "image#nix" = {
              path = "${../../../../../assets/nixos-logo.png}";
              tooltip = false;
            };

            "custom/update" = {
              format = "{}";
              exec = "${pkgs.update-notify}/bin/update-notify --waybar";
              return-type = "json";
              interval = 3600;
            };

            "custom/repo" =
              let
                check-repo = pkgs.writeShellScriptBin "check-repo" ''
                  cd "$HOME/nixos"
                  git fetch --quiet
                  if [ "$(git rev-parse HEAD)" != "$(git rev-parse @{u})" ]; then
                    echo "󰓦"
                  fi
                '';
              in
              {
                exec = "${check-repo}/bin/check-repo";
                tooltip = true;
                tooltip-format = "Local dotfiles repo is not up to date with origin/main";
                interval = 300;
              };

            "custom/power" = {
              format = "⏻";
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

              on-click = "hyprctl switchxkblayout current next";
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
              on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
              on-click-right = "${pkgs.pavucontrol}/bin/pavucontrol";
            };
          };
        };
      };

    };
  };
}
