{ pkgs, ... }:

pkgs.writeShellScriptBin "rff" ''
  echo -e "\e[?12l\e[?25l"
  trap 'echo -e "\e[?12h\e[?25h"; exit' SIGINT SIGTERM

  clear
  while true; do
      tput cup 0 0
      ${pkgs.fastfetch}/bin/fastfetch
      sleep 1
  done

  echo -e "\e[?12h\e[?25h"
''
