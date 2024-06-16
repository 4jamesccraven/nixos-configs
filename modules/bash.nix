{ pkgs, config, lib, ...}:

{
    home-manager.users.jamescraven = {
        # Set up Bash
        programs.bash = {
          enable = true;
          shellAliases = {
            c = "clear";
            cat = "bat";
            ff = "fastfetch";
            cff = "clear; fastfetch";
            build = "sudo nixos-rebuild switch -I nixos-config=$HOME/nixos/configuration.nix";
            clean-and-build = "sudo nix-collect-garbage -d; build";
          };
          bashrcExtra = ''
            fastfetch
            PS1="\[\e[38;2;202;158;230m\][\[\e[38;2;133;193;220m\]\u\[\e[38;2;202;158;230m\]@\h] \[\e[38;2;133;193;220m\]\w\n\[\e[38;2;202;158;230m\]$ \[\e[m\]"
          '';
        };
    };
}