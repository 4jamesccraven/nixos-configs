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
        clean-and-build = "sudo nix-collect-garbage -d && build";
      };
      bashrcExtra = ''
        fastfetch
        PS1="\[\e[38;2;202;158;230m\]┌─[\[\e[38;2;133;193;220m\]/ˈiː.ən/\[\e[38;2;202;158;230m\]@\h]:  \[\e[38;2;133;193;220m\]\w\n\[\e[38;2;202;158;230m\]└─󰊜 \[\e[m\]"
      '';
    };
  };
}
