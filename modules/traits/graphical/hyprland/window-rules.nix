{
  config,
  lib,
  ...
}:

/*
  ====[ Hyprland/window-rules ]====
  :: In trait `Graphical`
  Defines window rules for hyprland that force certain applications to launch
  floating instead of tiled.
*/
let
  /*
    mkRule :: { effects :: [string]; [string] :: string} -> string

    Takes an attribute set with a required attribute "effects," and one or more
    additional attributes. "effects" must contain a list of window rule effects
    to be applied (e.g., "center on"), and all other attributes describe a prop
    (e.g. `class = "test";`)

    See https://wiki.hypr.land/Configuring/Window-Rules
    ```repl
    > mkRule { class = "test"; effects = [ "center on" ]; }
    "match:class test, center on"
    ```
  */
  mkRule =
    { effects, ... }@propsUnfiltered:
    let
      props = lib.pipe propsUnfiltered [
        (lib.filterAttrs (name: _: name != "effects"))
        (lib.mapAttrsToList (type: rule: "match:${type} ${rule}"))
      ];
    in
    lib.join ", " (props ++ effects);

  /*
    floatRule :: attrs -> string

    Takes an attribute set of match props and applies a specific float rule to
    it.
  */
  floatRule =
    matchAttrs:
    let
      effects = [
        "float on"
        "size (1.15*monitor_h) (0.65*monitor_h)" # 0.65 * (16/9) ≈ 1.155
        "center on"
      ];
    in
    mkRule (matchAttrs // { inherit effects; });
in
{
  config = lib.mkIf config.hyprland.enable {
    home-manager.users.jamescraven = {

      wayland.windowManager.hyprland.settings = {
        # ---[ Generic Rules ]---
        windowrule = [
          # Float qalculate at a specific size.
          (mkRule {
            class = "qalculate-gtk";
            title = "Qalculate!";
            effects = [
              "float on"
              "size 800 250"
              "center on"
            ];
          })
        ]
        # ---[ Basic Float Rule ]---
        ++ (map floatRule [
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
