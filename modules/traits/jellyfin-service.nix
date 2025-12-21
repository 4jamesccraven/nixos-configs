{ pkgs, ... }:

# trait JellyfinService {
#     /// A machine that runs a Jellyfin server for others.
# }
{
  # Enable the service.
  services.jellyfin.enable = true;
  # Open the port to others
  networking.firewall.allowedTCPPorts = [
    8096
    50924
  ];

  # Having ffmpeg for debugging/editing is important.
  environment.systemPackages = with pkgs; [
    ffmpeg-full
  ];

  # Set up reverse proxy to port forward jellyfin.
  services.nginx = {
    enable = true;
    virtualHosts."_" = {
      listen = [
        {
          addr = "0.0.0.0";
          port = 50924;
        }
      ];

      locations."/" = {
        proxyPass = "http://127.0.0.1:8096";
      };
    };
  };
}
