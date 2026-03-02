{
  pkgs,
  lib,
  config,
  ...
}:

/*
  ====[ GNOME ]====
  :: In trait `Graphical`
  Defines a module that enables and configures GNOME
*/
{
  options = {
    gnome.enable = lib.mkEnableOption "Enables gnome";
  };

  config = lib.mkIf config.gnome.enable {
    # ---[ Enable and Configure GNOME Base ]---
    services.desktopManager.gnome.enable = true;
    # Exclude unnecessary packages (i.e., bloat)
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
      totem
      yelp
    ];

    # ---[ Theming ]---
    # :> Extensions
    environment.systemPackages = with pkgs.gnomeExtensions; [
      user-themes
    ];

    # :> Set shell theme (GTK) and wallpaper using DCONF
    programs.dconf.enable = true;
    home-manager.users.jamescraven = {
      dconf.settings = {
        # Force enable user-themes extension
        "org/gnome/shell" = {
          disable-user-extensions = false;
          disabled-extensions = [ ];
          enabled-extensions = [
            "user-theme@gnome-shell-extensions.gcampax.github.com"
          ];
        };

        # Set shell theme
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
