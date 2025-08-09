{
  pkgs,
  config,
  lib,
  ...
}:

{
  config = lib.mkIf config.hyprland.enable {
    environment.systemPackages = with pkgs; [
      quickshell
    ];
  };
}
