{ pkgs, config, lib, ...}:

{
  home-manager.users.jamescraven = {
    programs.btop = {
      enable = true;

      settings = {
        color_theme = "TTY";
        theme_background = false;
        proc_tree = true;
      };
    };
  };
}