{ pkgs, ... }:

/*
  ====[ GTK ]====
  :: dotfile

  Configures Colour Theme, Icon Theme, and Cursor Theme with GTK applications.
*/
{
  home-manager.users.jamescraven = {
    gtk = {
      enable = true;

      theme = {
        name = "catppuccin-mocha-mauve-standard";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "mauve" ];
          variant = "mocha";
          size = "standard";
        };
      };

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.catppuccin-papirus-folders.override {
          flavor = "mocha";
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
