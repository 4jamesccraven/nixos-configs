{ ... }:

{
  home-manager.users.jamescraven = {
    programs.hyprlock = {
      enable = true;

      settings = {
        background = {
          monitor = "";
          path = "/home/jamescraven/nixos/assets/wp-wide.png";
        };

        input-field = {
          monitor = "";
        };

        label = {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +\"%H:%M\")\"";
          "font_size" = 95;
          halign = "center";
          valign = "center";
        };
      };
    };
  };
}
