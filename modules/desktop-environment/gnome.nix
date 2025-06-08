{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    gnome.enable = lib.mkEnableOption "Enables gnome";
  };

  config = lib.mkIf config.gnome.enable {
    services.desktopManager.gnome.enable = true;

    # Exclude GNOME bloat
    environment.gnome.excludePackages = with pkgs; [
      epiphany
      geary
      gnome-clocks
      gnome-connections
      gnome-console
      gnome-contacts
      gnome-maps
      gnome-tour
      gnome-weather
      yelp
    ];

    # Enable DCONF
    programs.dconf.enable = true;

    home-manager.users.jamescraven = {
      # Force Shell Theme with Dconf
      dconf.settings = {
        # Force removal of disabled extensions
        # and enable user-theme
        "org/gnome/shell" = {
          disable-user-extensions = false;
          disabled-extensions = [ ];
          enabled-extensions = [
            "user-theme@gnome-shell-extensions.gcampax.github.com"
          ];
        };

        # Set Shell Theme
        "org/gnome/shell/extensions/user-theme" = {
          name = "catppuccin-mocha-mauve-standard";
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
