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

        #pulseaudio-slider trough {
          margin-left: 15px;
          min-width: 100px;
        }
      '';

      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 38;

          modules-left = [
            "network"
            "pulseaudio/slider"
            "hyprland/workspaces"
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
            format-icons = [ "" "" "" ];
            format-discharging = "{icon}    {capacity}%";
            format-charging = "󰂄    {capacity}%";
            interval = 15;
          };

          bluetooth = {
            format = "󰂯";
            on-click = "hyprctl dispatch exec [floating] blueman-manager";
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
            on-click = "hyprctl dispatch exec [floating] kitty nmtui connect";
          };
        };
      };
    };

  };
}
