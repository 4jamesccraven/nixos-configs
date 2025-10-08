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
}
