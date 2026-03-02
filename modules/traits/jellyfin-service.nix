{ pkgs, ... }:

/*
  ====[ Jellyfin ]====
  :: trait

  Configuration for Jellyfin media server.

  Enables:
    :> User Level
    ffmpeg => For debugging media issues & reformatting

    :> System Level
    Jellyfin => Media server
    nginx    => Reverse Proxy
    firewall => Opens 8096 locally and 50924 externally
*/
{
  # ---[ Jellyfin ]---
  services.jellyfin.enable = true;
  # Open the port to others
  networking.firewall.allowedTCPPorts = [
    8096
    50924
  ];

  # ---[ nginx ]---
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

  # ---[ ffmpeg ]---
  environment.systemPackages = with pkgs; [
    ffmpeg-full
  ];
}
