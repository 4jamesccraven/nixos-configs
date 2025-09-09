{
  config,
  lib,
  pkgs,
  ...
}:

{
  home-manager.users.jamescraven = {
    programs.alacritty = {
      enable = true;

      settings = {
        import = [ "${pkgs.alacritty-theme}/catppuccin_frappe.toml" ];

        font = {
          normal = {
            family = "FiraCode Nerd Font Mono";
            style = "Regular";
          };
          size = 11.75;
        };

        window.dimensions = {
          columns = 110;
          lines = 35;
        };

        window.opacity = 0.9;
      };
    };
  };

}
