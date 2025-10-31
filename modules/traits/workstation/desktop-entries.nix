{ ... }:

{
  home-manager.users.jamescraven = {
    xdg.desktopEntries = {
      shutdown = {
        name = "Shutdown";
        icon = "system-shutdown";
        exec = "shutdown now";
      };
      restart = {
        name = "Restart";
        icon = "system-restart";
        exec = "reboot";
      };
    };
  };
}
