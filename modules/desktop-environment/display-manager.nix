{ pkgs, ... }:

{
  services = {
    displayManager.gdm = {
      enable = true;
      autoSuspend = false;
    };

    xserver.excludePackages = with pkgs; [
      xterm
    ];
  };
}
