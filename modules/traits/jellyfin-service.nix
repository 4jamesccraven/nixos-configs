{ pkgs, ... }:

# trait JellyfinService {
#     /// A machine that runs a Jellyfin server for others.
# }
{
  # Enable the service.
  services.jellyfin.enable = true;
  # Open the port to others
  networking.firewall.allowedTCPPorts = [ 8096 ];

  # Having ffmpeg for debugging/editing is important.
  environment.systemPackages = with pkgs; [
    ffmpeg-full
  ];
}
