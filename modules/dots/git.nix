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
        includes =
          let
            catppuccin-delta = pkgs.fetchFromGitHub {
              owner = "catppuccin";
              repo = "delta";
              rev = "e9e21cffd98787f1b59e6f6e42db599f9b8ab399";
              hash = "sha256-04po0A7bVMsmYdJcKL6oL39RlMLij1lRKvWl5AUXJ7Q=";
            };
          in
          [
            { path = "${catppuccin-delta}/catppuccin.gitconfig"; }
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
