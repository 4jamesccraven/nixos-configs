{ pkgs, ... }:

pkgs.writeShellScriptBin "nx" ''
  usage="Usage: nx <build|clean|push|update|revert|develop>"
  ocwd=$(pwd)

  # Print usage with no args
  if [[ $# -eq 0 ]]; then
    echo "$usage"
    exit 1
  fi

  # Change to config dir and get sudo privileges
  cd "$HOME/nixos" || exit 1

  # Pop off the command and match
  cmd="$1"
  shift

  update() {
    local do_update=true
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --shells)
          do_update=false
          shift
          ;;
        *)
          echo "unknown option \`"$1"\`"
          echo "Usage: nx update [--shells]"
          exit 1
          ;;
      esac
    done

    if [[ "$do_update" == "true" ]]; then
      nix flake update
      nx build
    fi

    find ./shells -type f -name "*.nix" | while IFS= read -r file; do
      # Only cache shells where explicitly requested
      if grep -q "# CACHE" "$file"; then
        shell_name=$(basename "$file" .nix)
        nx develop "$shell_name" "echo cached $shell_name"
      fi
    done
  }

  push() {
    set -e
    git add flake.lock
    git commit -m "chore: system update"
    git push
  }

  clean() {
    set -e
    optimise=true
    cache_shells=true
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --no-optimise)
          optimise=false
          shift
          ;;
        --no-cache)
          cache_shells=false
          shift
          ;;
        *)
          echo "unknown option \`"$1"\`"
          echo "Usage: nx clean [--no-cache] [--no-optimise]"
          exit 1
          ;;
      esac
    done

    sudo nix-collect-garbage -d
    sudo -u jamescraven nix-collect-garbage -d
    nx build --fast

    if [[ "$cache_shells" == "true" ]]; then
      nx update --shells
    fi

    if [[ "$optimise" == "true" ]]; then
      nix store optimise
    fi
  }

  revert() {
    set -e
    local prompt="WARNING: You're attempting to revert to the following commit:"
    local commit_msg=$'\n  '$(git log -1 --pretty=%B)$'\n'
    local dialogue="Confirm? [y/n] (default: no)"$'\n'

    local response

    echo "$prompt"
    echo "$commit_msg"
    read -n 1 -sp "$dialogue" response

    case "$response" in
      y|Y)
        git reset --hard HEAD
        ;;
      *)
        echo "Aborted reset."
        exit 1
        ;;
    esac
  }

  build() {
    set -e
    no_pull=false
    while [[ $# -gt 0 ]]; do
      case "$1" in
        -f|--fast)
          no_pull=true
          shift
          ;;
        *)
          echo "unknown option \`"$1"\`"
          echo "Usage: nx build [-f|--fast]"
          exit 1
          ;;
        esac
    done

    if [[ "$no_pull" == "false" ]]; then
      git pull
    fi
    sudo nixos-rebuild switch --flake .
  }

  develop() {
    cd "$ocwd"

    if [[ "$1" ==  "-h" ]]; then
      echo "Usage: nx develop [shell] [command]"
      echo "Note: both arguments are optional, but \
  if command is specified, shell must be too."
      exit 0
    fi

    # $1 is a shell name, $2 is a command to run
    if [[ -n "$1" && -n "$2" ]]; then
      nix develop .#$1 -c $2 \
      || nix develop "$HOME/nixos#$1" -c $2 \
      || { echo "Unable to find a matching shell"; exit 1; }

    elif [[ -n "$1" ]]; then
      nix develop .#$1 -c zsh \
      || nix develop "$HOME/nixos#$1" -c zsh \
      || { echo "Unable to find a matching shell"; exit 1; }

    else
      nix develop || exit 1

    fi
  }

  case "$cmd" in
    update)  update  "$@";;
    push)    push    "$@";;
    clean)   clean   "$@";;
    revert)  revert  "$@";;
    build)   build   "$@";;
    develop) develop "$@";;
    *)
      echo "$usage"
      exit 1
  esac
''
