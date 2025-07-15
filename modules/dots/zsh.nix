{ pkgs, ... }:

{
  home-manager.users.jamescraven = {
    programs.zsh = {
      enable = true;

      defaultKeymap = "viins";

      dirHashes = {
        cd = "$HOME/Code";
        cfg = "$HOME/.config";
        dw = "$HOME/Downloads";
        nix = "$HOME/nixos";
        sw = "$HOME/Documents/Schoolwork";
        txt = "$HOME/Documents/Texts";
      };

      initContent = # bash
        ''
          # Disallow tabs at the start of prompt
          zstyle ':completion:*' insert-tab false

          setopt auto_param_slash  # Dirs are autocompleted with a trailing /
          setopt cdable_vars       # Try to prepend ~ if a cd command fails
          setopt cd_silent         # Don't pwd after cd
          setopt correct           # Offer to correct mispelled commands

          # fzf-zsh integration and theming
          source <(${pkgs.fzf}/bin/fzf --zsh)
          bindkey "^f" fzf-history-widget

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
        # Abbreviations
        c = "clear";
        ff = "fastfetch";
        cff = "clear; fastfetch";
        s = "kitten ssh";
        y = "yazi";
        ## Git
        ga = "git add . --all";
        gc = "git clone";
        gcm = "git commit";
        gd = "git diff ':!*lock'";
        gdf = "git diff";
        gds = "git diff --stat";
        gi = "git init";
        gl = "git log";
        gp = "git push origin HEAD";
        gs = "git status";
        gu = "git pull";
        gr = "git rev-parse --show-toplevel";
        ggr = "cd $(git rev-parse --show-toplevel)";
        gitaliases = "alias | grep git | grep -v gitaliases | sed 's/ *= */ = /' | column -t -s=";
        # Replacements
        cat = "bat";
        man = "batman";
        # Tools
        pcalc = "nix develop $HOME/nixos#dsci -c python";
      };
    };
  };
}
