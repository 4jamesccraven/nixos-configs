{ pkgs, ... }:

{
  services.xserver = {
    displayManager = {
      gdm = {
        enable = true;
        autoSuspend = false;
      };
    };

    excludePackages = with pkgs; [
      xterm
    ];
  };
}
