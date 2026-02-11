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
        name = "Reboot";
        icon = "system-restart";
        exec = "reboot";
      };
      chatgpt = {
        name = "ChatGPT";
        icon = "irc-chat";
        exec = "brave --new-window https://chatgpt.com";
      };
    };
  };
}
