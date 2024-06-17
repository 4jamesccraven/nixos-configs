{ pkgs, config, lib, ... }:

{

  home-manager.users.jamescraven = {
    # Alacritty settings
    programs.alacritty = {
      enable = true;
      
      # Quick and dirty way, didn't feel like understanding
      # overlays rn. Probably should revise eventually
      settings = {
        import = [ "${pkgs.alacritty-theme}/catppuccin_frappe.toml" ];

        font.normal = {
          family = "UbuntuMonoNerdFont";
          style = "Regular";
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
