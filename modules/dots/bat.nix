{ pkgs, ... }:

/*
  ====[ Bat ]====
  :: dotfile

  Enables bat, batman, and installs a catppuccin theme for it.
*/
{
  home-manager.users.jamescraven = {
    programs.bat = {
      enable = true;

      extraPackages = with pkgs.bat-extras; [
        batman
      ];

      themes = {
        "Catppuccin Mocha" = {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "6810349b28055dce54076712fc05fc68da4b8ec0";
            hash = "sha256-lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
          };
          file = "themes/Catppuccin Mocha.tmTheme";
        };
      };

      config.theme = "Catppuccin Mocha";
    };

    programs.zsh.shellAliases = {
      cat = "bat";
      man = "batman";
      lsblk = "lsblk | bat -l conf -pp";
    };
  };
}
