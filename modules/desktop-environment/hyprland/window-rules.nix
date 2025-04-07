{ lib, config, ... }:

{
  config = lib.mkIf config.hyprland.enable {
    home-manager.users.jamescraven = {

      wayland.windowManager.hyprland.settings = {
        windowrulev2 =
          let
            float = a: [
              "float, ${a}"
              "size 65% 65%, ${a}"
              "center, ${a}"
            ];
          in
          (lib.concatLists (
            lib.map float [
              "class:brave, title:^(.* wants to (open|save))$"
              "class:xdg-desktop-portal-gtk, title:^(.* wants to (open|save))$"
              "class:org.gnome.Nautilus"
              "class:org.telegram.desktop"
            ]
          ));
      };
    };
  };
}
