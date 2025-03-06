{...}:

{

  home-manager.users.jamescraven = {
    programs.fuzzel= {
      enable = true;

      settings = {
        main = {
          font = "FiraCode Nerd Font Mono:size=11";
          icon-theme = "Papirus-Dark";
        };
        border.width = 3;
        colors = {
          background = "303446ff";
          text = "c6d0f5ff";
          prompt = "ca9ee6ff";

          match = "c6d0f5ff";
          border = "ca9ee6ff";

          selection = "ca9ee6ff";
          selection-match = "303446ff";
          selection-text = "303446ff";
        };
      };
    };
  };

}
