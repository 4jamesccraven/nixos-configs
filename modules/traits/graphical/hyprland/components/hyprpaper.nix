{ config, lib, ... }:

{
  config = lib.mkIf config.hyprland.enable {
    home-manager.users.jamescraven = {
      services.hyprpaper = {
        enable = true;

        settings =
          let
            inherit (config.jcc) flakeRoot;
            wp-path = "${flakeRoot + /assets/wp-wide.png}";
          in
          {
            splash = false;

            wallpaper = [
              {
                monitor = "";
                path = "${wp-path}";
              }
            ];
          };
      };
    };
  };
}
