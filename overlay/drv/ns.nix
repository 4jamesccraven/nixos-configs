{
  pkgs ? import <nixpkgs> { },
  lib ? pkgs.lib,
  ...
}:

pkgs.writeShellApplication {
  name = "ns";

  runtimeInputs = with pkgs; [
    fzf
    gum
    nix-search-tv
  ];

  text = /* bash */ ''
    # ns - Nix search utilities.
    # Copyright (C) 2026  James C. Craven <4jamesccraven@gmail.com>
    #
    # This program is free software: you can redistribute it and/or modify
    # it under the terms of the GNU General Public License as published by
    # the Free Software Foundation, either version 3 of the License, or
    # (at your option) any later version.
    #
    # This program is distributed in the hope that it will be useful,
    # but WITHOUT ANY WARRANTY; without even the implied warranty of
    # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    # GNU General Public License for more details.
    #
    # You should have received a copy of the GNU General Public License
    # along with this program.  If not, see <https://www.gnu.org/licenses/>.
    FG=183

    usage() {
        cat <<EOF
    Nix search utilities.

    usage: ns [-h|--help] <SUBCOMMNAD>

    Commands
      shell      Start an interactive shell with some packages from nixpkgs.
      run        Run a program from nixpkgs.
      edit       Open the source code for a derivation from nixpkgs in \$EDITOR.
      homepage   Open the homepage for the selected package(s).
      source     Open the package's nix declaration.
      search     Search options (prints to stdout on selection).
      help       Print this help message and exit.

    Options
      -h,--help  Print this help message and exit.
      --license  Print license info and exit.

    Copyright (C) 2026  James C. Craven <4jamesccraven@gmail.com>
    EOF
    }

    license() {
        cat <<EOF
    ns - Nix search utilities.
    Copyright (C) 2026  James C. Craven <4jamesccraven@gmail.com>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
    EOF
    }

    await() {
        gum spin --spinner points \
             --spinner.foreground $FG \
             --title "Fetching Packages..." \
             -- bash -c "while kill -0 $1; do sleep 0.1; done"
    }

    subcommand=
    case "$1" in
        shell|source|run|edit|homepage|search)
            subcommand=$1
            ;;
        help|-h|--help)
            usage
            exit 0
            ;;
        license|--license)
            license
            exit 0
            ;;
        *)
            usage
            exit 1
            ;;
    esac
    shift

    # Begin caching the packages
    nix-search-tv print > /tmp/ns-packages.out &
    ntv_pid=$!


    # Determine the category of the search
    category=
    case "$subcommand" in
        search)
            category=$(
                gum choose \
                    --header "Search Category" \
                    --cursor.foreground $FG \
                    --selected.foreground $FG \
                    --header.foreground $FG \
                    nixpkgs home-manager nixos all
            )
            ;;
        *)
            category=nixpkgs
            ;;
    esac

    # Construct the parameters for the fuzzy search
    fzf_args=(
        --preview 'nix-search-tv preview {}'
        --height 50%
    )
    case "$category" in
        nixpkgs|home-manager|nixos)
            fzf_args+=(--query "$category/ ")
            ;;
    esac

    case "$subcommand" in
        shell|homepage|search)
            fzf_args+=(--multi)
            ;;
    esac

    # Wait until all the packages are available for searching
    await "$ntv_pid"

    # Get the user selection(s)
    mapfile -t raw_selection < <(
        fzf "''${fzf_args[@]}" < /tmp/ns-packages.out
    )

    # Transform for certain operations
    flake_args=("''${raw_selection[@]/#"$category/ "/"nixpkgs#"}")
    selections=("''${raw_selection[@]/#"$category/ "/}")

    case "$subcommand" in
        shell)
            exec nix shell "''${flake_args[@]}"
            ;;
        run)
            exec nix run "''${flake_args[0]}"
            ;;
        edit)
            exec nix edit "''${flake_args[0]}"
            ;;
        homepage)
            for selection in "''${raw_selection[@]}"; do
                xdg-open "''$(nix-search-tv homepage "$selection")"
            done
            ;;
        search)
            for selection in "''${selections[@]}"; do
                echo "$selection"
            done
            ;;
    esac
  '';

  meta = {
    license = lib.licenses.gpl3Plus;
    mainProgram = "ns";
  };
}
