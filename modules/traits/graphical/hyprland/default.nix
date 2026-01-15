{
  config,
  lib,
  ...
}:

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
    programs.hyprland.enable = true;

    home-manager.users.jamescraven = {

      wayland.windowManager.hyprland = {
        enable = true;

        settings = {
          ### Startup ###
          exec-once = [
            "hyprctl setcursor Dracula-cursors 22"
          ];

          ### Compatibility ###
          env = [
            "GDK_SCALE, 2"
            "XCURSOR_SIZE, 22"
          ];
          xwayland.force_zero_scaling = true;

          ### Input and Keybinds ###
          input = {
            kb_layout = "us,es";
            natural_scroll = false;
            numlock_by_default = true;

            touchpad = {
              natural_scroll = false;
            };
          };

          ### Appearance ###
          general =
            let
              accent = "rgb(${config.colors.accent.hex})";
              base = "rgb(${config.colors.base.hex})";
            in
            {
              border_size = 3;
              gaps_in = "5";
              "col.active_border" = accent;
              "col.inactive_border" = base;
              resize_on_border = true;
            };

          decoration = {
            rounding = "10";
            active_opacity = "0.95";
            inactive_opacity = "0.90";
          };

          misc = {
            disable_hyprland_logo = true;
          };

          # Please leave me alone
          ecosystem = {
            no_update_news = true;
            no_donation_nag = true;
          };

        };
      };

    };
  };
}
