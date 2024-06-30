{pkgs, lib, config, ...}:

{
  options = {
    gnome.enable = lib.mkEnableOption "Enables gnome";
  };

  config = lib.mkIf config.gnome.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable GNOME
    services.xserver = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      excludePackages = with pkgs; [
        xterm
      ];
    };

    # Exclude GNOME bloat
    environment.gnome.excludePackages = (with pkgs; [
      gnome-console
      gnome-connections
    ]) ++ (with pkgs.gnome; [
      epiphany
      gnome-contacts
      gnome-maps
      geary
    ]);

    # Enable DCONF
    programs.dconf.enable = true;

    home-manager.users.jamescraven = {
      # Enable and set generic GTK Theming
      gtk = {
        enable = true;

        theme = {
          name = "catppuccin-frappe-mauve-standard+default";
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

      # Force Shell Theme with Dconf
      dconf.settings = {
        # Force removal of disabled extensions
        # and enable user-theme
        "org/gnome/shell" = {
          disable-user-extensions = false;
          disabled-extensions = [];
          enabled-extensions = [
            "user-theme@gnome-shell-extensions.gcampax.github.com"
          ];
        };

        # Set Shell Theme
        "org/gnome/shell/extensions/user-theme" = {
          name = "catppuccin-frappe-mauve-standard+default";
        };

        # Set wallpaper
        "org/gnome/desktop/background" = {
          picture-uri = "file:///home/jamescraven/nixos/assets/wp-wide.png";
          picture-uri-dark = "file:///home/jamescraven/nixos/assets/wp-wide.png";
        };
      };
    };  
  };

}
