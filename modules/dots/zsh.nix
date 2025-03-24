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
        # Disallow tabs at the start of prompt
        zstyle ':completion:*' insert-tab false

        # Dirs are autocompleted with a trailing / instead of a space
        setopt auto_param_slash

        # Enable vim keybinds instead of default EMACS
        bindkey -v

        # fzf-zsh integration and theming
        source <(${pkgs.fzf}/bin/fzf --zsh)
        bindkey "^f" fzf-history-widget

        # Fzf theme
        export FZF_DEFAULT_OPTS=" \
        --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
        --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
        --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
        --color=selected-bg:#45475a \
        --color=border:#313244,label:#cdd6f4"

        # PROMPT='%F{#CA9EE6}╭─(%f/ˈiː.ən/%F{#CA9EE6}@%m): [%f%~%F{#CA9EE6}]
        # ╰─❯ %f'

        fastfetch
      '';

      shellAliases = {
        c = "clear";
        cat = "bat";
        man = "batman";
        ff = "fastfetch";
        cff = "clear; fastfetch";
        pcalc = "nix develop $HOME/nixos#dsci -c python";
      };
    };
  };
}
