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
  };
}
