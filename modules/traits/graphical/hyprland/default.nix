{
  config,
  lib,
  ...
}:

/*
  ====[ Hyprland/Default ]====
  :: In trait `Graphical`
  Defines a NixOS module that enables and configures Hyprland.
*/
{
  imports = [
    ./components
    ./binds.nix
    ./window-rules.nix
  ];

  options = {
    hyprland.enable = lib.mkEnableOption "Enable Hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    # Enable in *NixOS*
    programs.hyprland.enable = true;

    home-manager.users.jamescraven = {
      wayland.windowManager.hyprland = {
        enable = true; # Enable in *home-manager*

        settings = {
          # ---[ Startup ]----
          exec-once = [
            "hyprctl setcursor Dracula-cursors 22"
          ];

          # ---[ Compatibility ]---
          env = [
            "GDK_SCALE, 2"
            "XCURSOR_SIZE, 22"
          ];
          xwayland.force_zero_scaling = true;

          # ---[ Input ]---
          input = {
            kb_layout = "us,es"; # English & Spanish
            natural_scroll = false;
            numlock_by_default = true;

            touchpad = {
              natural_scroll = false;
            };
          };

          # ---[ Appearance ]---
          # :> Border Colours
          general =
            let
              colors = config.jcc.colors;
              accent = "rgb(${colors.accent.hex})";
              base = "rgb(${colors.base.hex})";
            in
            {
              border_size = 3;
              gaps_in = "5";
              "col.active_border" = accent;
              "col.inactive_border" = base;
              resize_on_border = true;
            };

          # :> Window Decoration
          decoration = {
            rounding = "10";
            active_opacity = "0.95";
            inactive_opacity = "0.90";
          };

          # ---[ Disable Annoyances ]---
          # :> Disable default wallpapers
          misc.disable_hyprland_logo = true;
          # :> Disable popups
          ecosystem = {
            no_update_news = true;
            no_donation_nag = true;
          };

        }; # settings
      };
    }; # home-manager

  }; # config
}
