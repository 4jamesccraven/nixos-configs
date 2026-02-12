{
  config,
  lib,
  jcc-utils,
  ...
}:

{
  config = lib.mkIf config.hyprland.enable {
    home-manager.users.jamescraven = {

      wayland.windowManager.hyprland.settings = {
        windowrule =
          let
            # float :: AttrSet -> [string]
            float =
              p:
              let
                # Turn each prop (match rule) into a formatted string using its
                # type and value
                props = jcc-utils.mapEntries (type: rule: "match:${type} ${rule}") p;
                # Join them with a comma
                m = lib.join "," props;
              in
              [
                # Apply a float, resize to 16:9 Aspect Ratio at 65% of screen height
                # and centre
                "${m}, float on"
                "${m}, size (1.15*monitor_h) (0.65*monitor_h)" # 0.65 * (16/9) ~~ 1.155
                "${m}, center on"
              ];
          in
          # Turn each set of conditions into a float rule, and combine into one list
          # of strings
          (builtins.concatMap float [
            {
              class = "brave";
              title = "^(.* wants to (open|save))$";
            }
            {
              class = ".blueman-manager-wrapped";
              title = "Bluetooth Devices";
            }
            {
              class = "brave";
              title = "Save File";
            }
            {
              class = "xdg-desktop-portal-gtk";
              title = "xdg-desktop-portal-gtk";
            }
            { class = "org.gnome.Nautilus"; }
            { class = "org.telegram.desktop"; }
            { class = "org.pulseaudio.pavucontrol"; }
          ]);
      };
    };
  };
}
