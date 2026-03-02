{ pkgs, ... }:

/*
  ====[ Graphical ]====
  :: trait

  A machine that has a Desktop Environment or Window Manager.

  Enables:
      :> System Level
      display manager    => GDM is enabled as the display manager for all graphical machines
      xdg desktop portal => Facilitates file dialogs etc.

      :> Config Level
      hyprland => Enablable NixOS module for hyprland
      gnome    => Enablable NixOS module for GNOME
*/
{
  imports = [
    # :> super traits
    ../machine.nix
    # :> trait omponents
    ./display-manager.nix
    ./gnome.nix
    ./hyprland
  ];

  # ---[ XDG Desktop Portal ]---
  xdg.portal = {
    enable = true;
    # Ensure GTK is installed and used no matter what
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config.common.default = [
      "gtk"
    ];
  };
}
