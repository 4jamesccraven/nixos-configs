{ ... }:

{
  home-manager.users.jamescraven = {
    programs.hyprlock = {
      enable = true;

      settings = {
        background = {
          monitor = "";
          path = "/home/jamescraven/nixos/assets/wp-wide.png";

          blur_passes = 2;
        };

        input-field = {
          monitor = "";
          size = "10%, 4%";
          fade_on_empty = false;

          halign = "center";
          valign = "center";
          position = "0, -5%";

          outer_color = "rgb(202, 158, 230)";
          inner_color = "rgb(48, 52, 70)";
          font_color = "rgb(198, 208, 245)";
          check_color = "rgb(198, 208, 245)";
          fail_color = "rgb(231, 130, 132)";
        };

        label = {
          monitor = "";
          text = "$TIME";
          font_size = 95;
          font_family = "FiraCode Nerd Font Mono";

          halign = "center";
          valign = "center";
          position = "0, 10%";

          color = "rgb(198, 208, 245)";
        };

        image = {
          monitor = "";
          path = "${../../../assets/nixos-logo.png}";
          size = 80;

          halign = "center";
          valign = "bottom";

          border_color = "rgb(202, 158, 230)";
        };
      };
    };
  };
}
