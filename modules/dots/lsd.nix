{ ... }:

{
  home-manager.users.jamescraven = {
    programs.lsd = {
      enable = true;

      enableAliases = true;

      settings = {
        blocks = [
          "permission"
          "user"
          "group"
          "date"
          "size"
          "name"
        ];

        sorting.dir-grouping = "first";
        total-size = true;
        date = "+%D";
        symlink-arrow = "->";
      };

      colors = {
        user = "blue";
        group = "blue";
        date = {
          hour-old = "green";
          day-old = "green";
          older = "green";
        };
        size = {
          small = "grey";
          medium = "yellow";
          large = "dark_red";
        };
      };
    };
  };
}
