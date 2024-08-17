{ config, lib, ... }:

{
  config = lib.mkIf config.hyprland.enable {
    home-manager.users.jamescraven = {
      services.hyprpaper = {
        enable = true;

        settings = {
          preload = [
            "/home/jamescraven/nixos/assets/wp-wide.png"
          ];

          wallpaper = [
            "eDP-1,/home/jamescraven/nixos/assets/wp-wide.png"
          ];
        };
      };
    };
  };
}
