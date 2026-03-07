{ config, ... }:

/*
  ====[ Bash ]====
  :: dotfile

  Enables and configures a minimal bash config.
*/
{
  home-manager.users.jamescraven = {
    programs.bash = {
      enable = true;
      shellAliases = config.ext.shell-aliases;
      bashrcExtra = /* bash */ ''
        if ! command -v starship > /dev/null 2>&1; then
          PS1='/ˈiː.ən/\[\e[31m\]@\h [\[\e[0m\]\w\[\e[31m\]]\n=> \[\e[0m\]'
        fi
      '';
    };
  };
}
