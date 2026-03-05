{
  pkgs ? import <nixpkgs> { },
  ...
}:

pkgs.writeShellScriptBin "tor-dl" ''
  cleanup() {
      if kill -0 "$TOR_PID" 2>/dev/null; then
          kill "$TOR_PID"
          wait "$TOR_PID" 2>/dev/null
      fi
  }

  ${pkgs.tor}/bin/tor --RunAsDaemon 1 > /dev/null 2>&1 &
  TOR_PID=$!

  until nc -z 127.0.0.1 9050; do
    sleep 0.5
  done

  trap cleanup EXIT INT TERM

  exec ${pkgs.tor}/bin/torify ${pkgs.yt-dlp}/bin/yt-dlp "$@"
''
