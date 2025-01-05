{ pkgs, ... }:

pkgs.writeShellScriptBin "nx" ''
  usage="Usage: nx [build, clean, push, update, reset]"
  rdir=$(pwd)

  if [[ $# -ne 1 ]]; then
    echo "$usage"
    exit 1
  fi

  cd "$HOME/nixos" || exit 1
  sudo -v || exit 1

  case "$1" in
    update)
      set -e
      nix flake update
      nx build
    ;;
    push)
      set -e
      git add flake.lock
      git commit -m "chore: system update"
      git push
    ;;
    clean)
      set -e
      sudo nix-collect-garbage -d
      sudo -u jamescraven nix-collect-garbage -d
      nx build
    ;;
    reset)
      set -e
      git reset --hard HEAD
    ;;
    build)
      git pull
      sudo nixos-rebuild switch --flake .
    ;;
    *)
      echo "$usage"
      exit 1
  esac

  cd "$rdir" || exit 1
''
