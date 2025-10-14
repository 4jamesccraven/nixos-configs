{ pkgs, ... }:

pkgs.writeShellScriptBin "update-notify" ''
  last_update=$(
      git -C "$HOME/nixos" log --format="%ad %s" --date="format:%D" |
          grep -i "chore: system update" |
          head -n 1 |
          awk '{print $1}'
  )

  days=$(( ($(date +%s) - $(date +%s -ud "$last_update")) / 3600 / 24 ))

  if [ "$1" = "--waybar" ]; then
      if (( days >= 21 )); then
          class="late"
      elif (( days >= 14 )); then
          class="warn"
      else
          class="ok"
      fi

      case "$class" in
          ok)
              icon=""
              ;;
          warn)
              icon=""
              ;;
          late)
              icon="󰗎"
              ;;
      esac

      printf '{"text": "%s", "class": "%s", "tooltip": "%s days since last update"}' \
          "$icon" "$class" "$days"
  else
      echo "''${days} days since last update"
  fi
''
