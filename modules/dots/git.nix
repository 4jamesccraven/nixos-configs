{ pkgs, ... }:

/*
  ====[ Git ]====
  :: dotfile

  Enable and configure git, the version control system.
  Also includes Delta, an alternate text pager for git.
*/
{

  home-manager.users.jamescraven = {
    programs = {
      # ---[ Git Settings ]--
      git = {
        # :> General
        enable = true;
        settings = {
          init.defaultBranch = "main";
          core.editor = "nvim";

          user = {
            name = "4jamesccraven";
            email = "4jamesccraven@gmail.com";
          };
        };

        # :> Theme for Delta
        includes = [
          { path = "${pkgs.catppuccin-delta}/catppuccin.gitconfig"; }
        ];
      };

      # ---[ Delta Settings ]---
      delta = {
        enable = true;
        enableGitIntegration = true;
        options.features = "catppuccin-mocha";
      };
    };
  };

}
