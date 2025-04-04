{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hyprland-submodules
  ];

  options = {
    hyprland.enable = lib.mkEnableOption "Enable Hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    programs.hyprland.enable = true;

    environment.systemPackages = with pkgs; [
      brightnessctl
      grim
      slurp
    ];

    home-manager.users.jamescraven = {

      wayland.windowManager.hyprland = {
        enable = true;

        settings = {
          "$mod" = "SUPER";

          exec-once = [
            "hyprctl setcursor Dracula-cursors 22"
            "hyprpaper"
          ];

          xwayland.force_zero_scaling = true;

          env = [
            "GDK_SCALE, 2"
            "XCURSOR_SIZE, 22"
          ];

          windowrulev2 = [
            "float, class:brave, title:^(.* wants to (open|save))$"
            "float, class:xdg-desktop-portal-gtk, title:^(.* wants to (open|save))$"
          ];

          ### Appearance ###

          general =
            let
              accent = "rgb(${config.colors.accent.hex})";
              base = "rgb(${config.colors.base.hex})";
            in
            {
              "border_size" = 3;
              "gaps_in" = "5";
              "col.active_border" = accent;
              "col.inactive_border" = base;
              "resize_on_border" = true;
            };

          decoration = {
            "rounding" = "10";
            "active_opacity" = "0.95";
            "inactive_opacity" = "0.90";
          };

          misc = {
            "disable_hyprland_logo" = true;
          };

          ### Input and Keybinds ###

          input = {
            "kb_layout" = "us,es";
            "natural_scroll" = false;

            touchpad = {
              "natural_scroll" = false;
            };
          };

          bind = [
            # General
            "$mod, Q, killactive"
            "Alt_L, Space, exec, fuzzel"

            # Fullscreen control
            "$mod, M, fullscreen, 1"
            "$mod+Shift, M, fullscreen, 0"

            # Float
            "$mod, F, togglefloating"
            "$mod, F, centerwindow"
            "$mod, F, resizeactive, exact 65% 65%"

            # Minimize trick
            "$mod, Z, togglespecialworkspace, mincontainer"
            "$mod, Z, movetoworkspace, +0"
            "$mod, Z, togglespecialworkspace, mincontainer"
            "$mod, Z, movetoworkspace, special:mincontainer"
            "$mod, Z, togglespecialworkspace, mincontainer"

            # System Power
            "$mod, L, exec, hyprlock"
            "$mod, V, exec, hyprctl dispatch exit"
            "$mod+Shift, V, exec, shutdown now"

            # Keyboard navigation
            "Alt_L, H, movefocus, l"
            "Alt_L, J, movefocus, d"
            "Alt_L, K, movefocus, u"
            "Alt_L, L, movefocus, r"

            "$mod+Shift, H, movewindow, l"
            "$mod+Shift, J, movewindow, d"
            "$mod+Shift, K, movewindow, u"
            "$mod+Shift, L, movewindow, r"

            "$mod, 1, workspace, 1"
            "$mod, 2, workspace, 2"
            "$mod, 3, workspace, 3"
            "$mod, 4, workspace, 4"
            "$mod+Shift, 1, movetoworkspace, 1"
            "$mod+Shift, 2, movetoworkspace, 2"
            "$mod+Shift, 3, movetoworkspace, 3"
            "$mod+Shift, 4, movetoworkspace, 4"

            # Keyboard Layouts
            "Alt_L, Shift_L, exec, hyprctl switchxkblayout at-translated-set-2-keyboard next"
            "Alt_L, Shift_L, exec, hyprctl switchxkblayout keychron-keychron-c2 next"

            # Screenshots
            ", Print, exec, GRIM_DEFAULT_DIR=\"/home/jamescraven/Pictures/Screenshots\" grim -g \"$(slurp)\""
            "Shift_L, Print, exec, GRIM_DEFAULT_DIR=\"/home/jamescraven/Pictures/Screenshots\" grim"
            "Shift_L, Print, exec, hyprctl notify 1 1500 0 \"fontsize:25 Screen Captured\""
          ];

          # Sound
          bindel = [
            ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
            ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
            ", XF86MonBrightnessUp, exec, brightnessctl set 10%+"
          ];

          bindl = [
            ", XF86AudioRaiseVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0"
            ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ", switch:Lid Switch, exec, hyprlock"
          ];

          # Mouse Navigation
          bindm = [
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
          ];
        };
      };

    };
  };
}
