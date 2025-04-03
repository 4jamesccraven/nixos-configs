{ pkgs, ... }:

{
  home-manager.users.jamescraven =
    let
      format = pkgs.formats.toml { };
      config = format.generate "config.toml" {
        recipe_dir = "/home/jamescraven/nixos/assets/mkdev";

        subs = {
          day = "date +%d";
          user = "whoami";
          year = "date +%Y";
          dir = "mk::dir";
          month = "date +%m";
        };
      };
    in
    {
      xdg.configFile."mkdev/config.toml".source = config;
    };
}
