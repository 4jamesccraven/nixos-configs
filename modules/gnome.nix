{pkgs, lib, config, ...}: {
  
  options = {
    gnome.enable = lib.mkEnableOption "Enables gnome";
  };

  config = lib.mkIf config.gnome.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable GNOME
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    # Enable DCONF
    programs.dconf.enable = true;

    home-manager.users.jamescraven = {
      # Enable and set generic GTK Theming
      gtk = {
        enable = true;

        theme = {
          name = "Catppuccin-Frappe-Standard-Mauve-Dark";
          package = pkgs.catppuccin-gtk.override {
            accents = ["mauve"];
            variant = "frappe";
          };
        };

	iconTheme = {
	  name = "Papirus-Dark";
	  package = pkgs.catppuccin-papirus-folders.override {
	    flavor = "frappe";
	    accent = "mauve";
	  };
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
          name = "Catppuccin-Frappe-Standard-Mauve-Dark";
        };

	# Set wallpaper
	"org/gnome/desktop/background" = {
          picture-uri = "file:///etc/nixos/assets/wp.png";
          picture-uri-dark = "file:///etc/nixos/assets/wp.png";
	};
      };
    };  
  };

}
