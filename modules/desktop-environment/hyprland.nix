{ config, lib, pkgs, ...}:

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
      wofi
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

          ### Appearance ###

          general = {
            "border_size" = 3;
            "gaps_in" = "5";
            "col.active_border" = "rgb(ca9ee6)";
            "col.inactive_border" = "rgb(292c3c)";
          };

          decoration = {
            "rounding" = "10";
            "active_opacity" = "0.95";
            "inactive_opacity" = "0.90";
          };

          layerrule = [
            "noanim, ^(wofi)$"
          ];

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
            "Alt_L, Space, exec, wofi --show drun"
            "$mod, m, fullscreen, 1"
            "$mod+Shift, m, fullscreen, 0"
            "$mod, B, exec, hyprlock"
            "$mod, X, exec, hyprctl dispatch exit"

            "$mod, h, movefocus, l"
            "$mod, j, movefocus, d"
            "$mod, k, movefocus, u"
            "$mod, l, movefocus, r"

            "$mod+Shift, h, movewindow, l"
            "$mod+Shift, j, movewindow, d"
            "$mod+Shift, k, movewindow, u"
            "$mod+Shift, l, movewindow, r"

            "Alt_L, Shift_L, exec, hyprctl switchxkblayout at-translated-set-2-keyboard next"
            "Alt_L, Shift_L, exec, hyprctl switchxkblayout keychron-keychron-c2 next"
          ];

          bindel = [
            ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
            ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ];

          bindl = [
            ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ];
        };
      };

    };
  };
}
