{ ... }:

{
  home-manager.users.jamescraven = {
    programs.kitty = {
      enable = true;

      font = {
        name = "FiraCode Nerd Font Mono";
        size = 11.75;
      };
      
      themeFile = "Catppuccin-Frappe";

      settings = {
        background_opacity = "0.9";
      };
    };
  };
}
