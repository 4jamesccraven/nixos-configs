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

          ### Appearance ###

          general = {
            "border_size" = 3;
            "gaps_in" = "5";
            "col.active_border" = "rgb(ca9ee6)";
            "col.inactive_border" = "rgb(292c3c)";
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
            "$mod, T, exec, kitty"
            "$mod, Q, killactive"
            "Alt_L, Space, exec, fuzzel"

            "$mod, m, fullscreen, 1"
            "$mod+Shift, m, fullscreen, 0"

            "$mod, f, togglefloating"
            "$mod, f, centerwindow"

            "$mod, B, exec, hyprlock"
            "$mod, X, exec, hyprctl dispatch exit"
            "$mod+Shift, X, exec, shutdown now"

            "$mod, h, movefocus, l"
            "$mod, j, movefocus, d"
            "$mod, k, movefocus, u"
            "$mod, l, movefocus, r"

            "$mod+Shift, h, movewindow, l"
            "$mod+Shift, j, movewindow, d"
            "$mod+Shift, k, movewindow, u"
            "$mod+Shift, l, movewindow, r"

            "$mod, 1, workspace, 1"
            "$mod, 2, workspace, 2"
            "$mod, 3, workspace, 3"
            "$mod, 4, workspace, 4"
            "$mod+Shift, 1, movetoworkspace, 1"
            "$mod+Shift, 2, movetoworkspace, 2"
            "$mod+Shift, 3, movetoworkspace, 3"
            "$mod+Shift, 4, movetoworkspace, 4"

            "Alt_L, Shift_L, exec, hyprctl switchxkblayout at-translated-set-2-keyboard next"
            "Alt_L, Shift_L, exec, hyprctl switchxkblayout keychron-keychron-c2 next"

            ", Print, exec, GRIM_DEFAULT_DIR=\"/home/jamescraven/Pictures/Screenshots\" grim -g \"$(slurp)\""
            "Shift_L, Print, exec, GRIM_DEFAULT_DIR=\"/home/jamescraven/Pictures/Screenshots\" grim"
          ];

          bindel = [
            ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
            ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
            ", XF86MonBrightnessUp, exec, brightnessctl set 10%+"
          ];

          bindl = [
            ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ];

          bindm = [
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
          ];
        };
      };

    };
  };
}
