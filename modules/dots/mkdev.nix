{ pkgs, inputs, ... }:

/*
  ====[ Mkdev ]====
  :: dotfile

  Enables and configures mkdev, a command line tool for project templates.
*/
{
  home-manager.users.jamescraven = {
    imports = [
      inputs.mkdev.homeManagerModule
    ];

    programs.mkdev = {
      enable = true;

      extraPackages = with inputs.mkdev.packages.${pkgs.stdenv.hostPlatform.system}; [
        mkf
      ];

      # :> User Config
      config = {
        recipe_dir = "/home/jamescraven/.config/mkdev/recipes";

        subs = {
          day = "date +%d";
          dir = "mk::dir";
          name = "mk::name";
          month = "date +%m";
          user = "whoami";
          year = "date +%Y";
        };
      };

      # :> Project Templates
      recipes = [ ];
    };
  };
}
