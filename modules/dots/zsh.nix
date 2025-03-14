{ pkgs, ... }:

{
  home-manager.users.jamescraven = {
    programs.zsh = {
      enable = true;

      dirHashes = {
        cd = "$HOME/Code";
        dcs = "$HOME/Documents";
        nix = "$HOME/nixos";
        sw = "$HOME/Documents/Schoolwork";
      };

      initExtra = ''
        zstyle ':completion:*' insert-tab false # Disallow tabs at the start of prompt

        setopt auto_param_slash           # dirs are autocompleted with a trailing / instead of a space

        source <(${pkgs.fzf}/bin/fzf --zsh)

        bindkey "^f" fzf-history-widget

        PROMPT='%F{#CA9EE6}╭─(%f/ˈiː.ən/%F{#CA9EE6}@%m): [%f%~%F{#CA9EE6}]
        ╰─❯ %f'

        if command -v starship &> /dev/null; then
          eval "$(starship init zsh)"
        fi

        fastfetch
      '';

      shellAliases = {
        c = "clear";
        cat = "bat";
        ff = "fastfetch";
        cff = "clear; fastfetch";
        pcalc = "nx develop dsci python";
      };
    };
  };
}
