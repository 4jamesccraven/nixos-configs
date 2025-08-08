{ ... }:

{

  home-manager.users.jamescraven = {
    programs.btop = {
      enable = true;

      settings = {
        color_theme = "TTY";
        theme_background = false;
        proc_tree = false;
        vim_keys = true;
      };
    };

    xdg.desktopEntries = {
      btop = {
        type = "Application";
        name = "btop++";
        genericName = "System Monitor";
        comment = "Resource monitor that shows usage and stats for processor, memory, disks, network and processes";
        icon = "btop";
        exec = "wezterm start btop";
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
