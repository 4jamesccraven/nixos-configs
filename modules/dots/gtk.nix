{ pkgs, ... }:

{
  home-manager.users.jamescraven = {
    gtk = {
      enable = true;

      theme = {
        name = "catppuccin-frappe-mauve-standard";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "mauve" ];
          variant = "frappe";
          size = "standard";
        };
      };

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.catppuccin-papirus-folders.override {
          flavor = "frappe";
          accent = "mauve";
        };
      };

      cursorTheme = {
        name = "Dracula-cursors";
        package = pkgs.dracula-cursors;
      };
    };
  };
}
