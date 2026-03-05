{
  pkgs ? import <nixpkgs> { },
  ...
}:

pkgs.writeShellScriptBin "screenie" /* bash */ ''
  mode=''${1:-region}
  time=$(date +%F_%H%M%S)

  ${pkgs.hyprshot}/bin/hyprshot -m "$mode" -zs --raw \
  | ${pkgs.satty}/bin/satty --filename - \
    --output-filename "/home/jamescraven/Pictures/Screenshots/screenshot_$time.png" \
    --copy-command wl-copy \
    --init-tool brush \
    --actions-on-escape exit \
    --early-exit
''
