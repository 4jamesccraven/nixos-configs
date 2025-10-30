{ pkgs, ... }:

# trait Graphical: Machine {
#     /// A machine that has a Desktop Environment or Window Manager
#     hyprland        => Enablable configuration for hyprland;
#     gnome           => Enablable configuration for GNOME;
#     display manager => GDM is enabled as the display manager for all graphical machines;
# }
{
  imports = [
    # super traits
    ../machine.nix
    # trait omponents
    ./display-manager.nix
    ./gnome.nix
    ./hyprland
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config.common.default = [
      "gtk"
    ];
  };
}
