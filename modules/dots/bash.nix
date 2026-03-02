{ ... }:

/*
  ====[ Bash ]====
  :: dotfile

  Enables and configures a minimal bash config.
*/
{
  home-manager.users.jamescraven = {
    programs.bash = {
      enable = true;
      shellAliases = {
        c = "clear";
        cat = "bat";
        ff = "fastfetch";
        cff = "clear; fastfetch";
      };
      bashrcExtra = /* bash */ ''
        fastfetch
        PS1="\[\e[38;2;202;158;230m\]┌─[\[\e[m\]/ˈiː.ən/\[\e[38;2;202;158;230m\]@\h]: ❄ \[\e[m\]\w\n\[\e[38;2;202;158;230m\]└─> \[\e[m\]"
      '';
    };
  };
}
