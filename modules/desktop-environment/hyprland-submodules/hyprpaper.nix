{ config, lib, ... }:

{
  config = lib.mkIf config.hyprland.enable {
    home-manager.users.jamescraven = {
      services.hyprpaper = {
        enable = true;

        settings =
          let
            wp-path = "${../../../assets/wp-wide.png}";
          in
          {
            preload = [
              wp-path
            ];

            wallpaper = [
              "eDP-1,${wp-path}"
              "DP-3,${wp-path}"
              "HDMI-A-1,${wp-path}"
            ];
          };
      };
    };
  };
}
