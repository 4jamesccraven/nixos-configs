{ pkgs, ... }:

# trait Gaming {
#     /// Additional software and settings gaming setups
#     steam/heroic   => software for installing and running games;
#     piper/ratbag   => software for managing mouse sensitivity;
#     xpadneo        => drivers for controllers;
#     openrgb        => rgb lighting support (technically not gaming specific);
#     gamemode/scope => software for improving game peformance;
# }
{
  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    heroic # Epic games
    piper
  ];

  # Hardware support
  # Mouse DPI
  services.ratbagd.enable = true;
  systemd.services.ratbagd.wantedBy = [ "multi-user.target" ];
  # RGB lighting
  services.hardware.openrgb.enable = true;
  # Controller support
  hardware.xpadneo.enable = true;

  # Software support
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  # Fix for Assassin's Creed contacting defunct servers:
  networking.extraHosts = ''
    # Redirect legacy Ubisoft servers to localhost to prevent game freezes
    216.98.48.18 127.0.0.1
    216.98.48.53 127.0.0.1
    216.98.48.57 127.0.0.1
    216.98.48.133 127.0.0.1
    216.98.48.134 127.0.0.1
  '';
}
