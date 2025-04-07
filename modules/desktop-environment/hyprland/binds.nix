{ pkgs, lib, config, ... }:

{
  config = lib.mkIf config.hyprland.enable {
    environment.systemPackages = with pkgs; [
      brightnessctl
      grim
      slurp
    ];

    home-manager.users.jamescraven = {
      wayland.windowManager.hyprland.settings = {
        "$mod" = "SUPER";

        bind = [
          # General
          "$mod, Q, killactive"
          "Alt_L, Space, exec, fuzzel"

          # Fullscreen control
          "$mod, M, fullscreen, 1"
          "$mod+Shift, M, fullscreen, 0"

          # Float
          "$mod, F, togglefloating"
          "$mod, F, resizeactive, exact 65% 65%"
          "$mod, F, centerwindow"

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

          # Keyboard Navigation
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

        bindel = [
          # Sound
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
          ", XF86MonBrightnessUp, exec, brightnessctl set 10%+"
        ];

        bindl = [
          # Sound
          ", XF86AudioRaiseVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", switch:Lid Switch, exec, hyprlock"
        ];

        bindm = [
          # Window Manipulation
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
      };
    };
  };
}
