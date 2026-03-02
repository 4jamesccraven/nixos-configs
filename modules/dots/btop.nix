{ ... }:

/*
  ====[ Btop ]====
  :: dotfile

  Enables and configures btop, a system resource manager.
*/
{
  home-manager.users.jamescraven = {
    # :> Settings
    programs.btop = {
      enable = true;

      settings = {
        color_theme = "TTY";
        theme_background = false;
        proc_tree = false;
        vim_keys = true;
      };
    };

    # :> Destop Entry Override
    # (makes the desktop entry use kitty instead of xterm)
    xdg.desktopEntries = {
      btop = {
        type = "Application";
        name = "btop++";
        genericName = "System Monitor";
        comment = "Resource monitor that shows usage and stats for processor, memory, disks, network and processes";
        icon = "btop";
        exec = "kitty btop";
        terminal = false;
        categories = [
          "System"
          "Monitor"
          "ConsoleOnly"
        ];
      };
    };
  };
}
