{ pkgs, ...}:

{

  home-manager.users.jamescraven = {
    programs.bat = {
      enable = true;

      themes = {
        "Catppuccin Frappe" = {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "d714cc1d358ea51bfc02550dabab693f70cccea0";
            sha256 = "1zlryg39y4dbrycjlp009vd7hx2yvn5zfb03a2vq426z78s7i423";
          };
          file = "themes/Catppuccin Frappe.tmTheme";
        };
      };

      config.theme = "Catppuccin Frappe";
    };
  };

}
