{...}:

{
  home-manager.users.jamescraven = {
    programs.bash = {
      enable = true;
      shellAliases = {
        c = "clear";
        cat = "bat";
        ff = "fastfetch";
        cff = "clear; fastfetch";
        build = "sudo nixos-rebuild switch --flake /home/jamescraven/nixos";
        clean-and-build = "sudo nix-collect-garbage -d && sudo -u jamescraven nix-collect-garbage -d && build";
      };
      bashrcExtra = /*bash*/ ''
        fastfetch
        PS1="\[\e[38;2;202;158;230m\]┌─[\[\e[m\]/ˈiː.ən/\[\e[38;2;202;158;230m\]@\h]: ❄ \[\e[m\]\w\n\[\e[38;2;202;158;230m\]└─> \[\e[m\]"
      '';
    };
  };

  home-manager.users.fia = {
    programs.bash = {
      enable = true;
      shellAliases = {
        c = "clear";
        fia-start = "XDG_SESSION_TYPE=wayland exec dbus-run-session gnome-session";
      };

      bashrcExtra = /*bash*/ ''
        PS1="\[\e[92m\]┌─[\[\e[0m\]\u\[\e[92m\]@\h]: \[\e[0m\]\w\n\[\e[92m\]└─> \[\e[0m\]"
      '';
    };
  };
}
