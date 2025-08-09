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

      syntaxHighlighting = {
        enable = true;
        highlighters = [
          "main"
          "brackets"
          "regexp"
        ];
      };

      autosuggestion.enable = true;

      setOptions = [
        "auto_param_slash" # Dirs are autocompleted with a trailing /
        "cdable_vars" # cd into a hashed dir without typing ~
        "cd_silent" # Don't pwd after cd
        "correct" # Offer to correct mispelled commands
      ];

      siteFunctions = {
        # A wrapper around basic nix functionality, mostly delegates
        # to the just file for this config
        nx = # bash
          ''
            nx() {
              _nxd() {
                  local shell="default"
                  local command="zsh"
                  local global=false

                  if [[ $# -gt 0 && "$1" != -* ]]; then
                      shell="$1"
                      shift
                  fi

                  while [[ $# -gt 0 ]]; do
                      case "$1" in
                          -c|--command)
                              command="$2"
                              shift 2
                              ;;
                          -g|--global)
                              global=true
                              shift
                              ;;
                          *)
                              echo "Unknown argument $1"
                              return 1
                              ;;
                      esac
                  done

                  if $global; then
                      dir="/home/jamescraven/nixos"
                  else
                      dir="."
                  fi

                  nix develop "''${dir}#''${shell}" -c "$command"
              }

              # If of form `nx d` use the above function
              if [ "$1" = "d" ] || [ "$1" = "develop" ]; then
                shift
                _nxd "$@"
              # Other wise delegate to justfile
              else
                just --justfile /home/jamescraven/nixos/justfile "$@"
              fi
            }
          '';
      };

      initContent = # bash
        ''
          zstyle ':completion:*' insert-tab false # Disable inserting tab at the beginning of a line

          # fzf-zsh integration and theming
          source <(${pkgs.fzf}/bin/fzf --zsh)
          bindkey "^f" fzf-history-widget

          bindkey "^a" autosuggest-accept

          export FZF_DEFAULT_OPTS=" \
          --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
          --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
          --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
          --color=selected-bg:#45475a \
          --color=border:#313244,label:#cdd6f4"

          # Fallback
          if ! command -v starship > /dev/null 2>&1; then
            PROMPT='/ˈiː.ən/%F{red}@%m [%f%~%F{red}]
          => %f'
          fi
        '';

      shellAliases = {
        # Abbreviations
        c = "clear";
        cff = "clear; fastfetch";
        ff = "fastfetch";
        j = "just";
        s = "ssh";
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
        # Tools
        pcalc = "nix develop $HOME/nixos#dsci -c python";
      };
    };
  };
}
