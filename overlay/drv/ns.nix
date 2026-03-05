{
  pkgs ? import <nixpkgs> { },
  ...
}:

pkgs.writeShellScriptBin "ns" (
  let
    ntv = "${pkgs.nix-search-tv}/bin/nix-search-tv";
    gum = "${pkgs.gum}/bin/gum";
    fzf = "${pkgs.fzf}/bin/fzf";
  in
  /* bash */ ''
    case "$1" in
        help|--help|-h)
            ${gum} format -- "## usage: ns [help|shell|run|edit|homepage]" \
                "### NOTE: the following options are only available when source is nixpkgs." \
                "- shell: open the package in a nix shell" \
                "- run: run the main program of the package" \
                "- edit: open the source code for the derivation in your \$EDITOR" \
                "- homepage: open the home-page of the package in your browser" \
                "- none: print the selected package"
            exit 0
            ;;
    esac

    # Determine package source to query; this allows us to filter the outputs of nix-search-tv
    CAT=$(${gum} choose --header "Search Category" \
          --cursor.foreground 183 --selected.foreground 183 --header.foreground 183 \
          nixpkgs home-manager nixos nur all)

    [ -z "$CAT" ] && exit 1

    # Setup a filter if one is provided, or leave it blank
    case "$CAT" in
        home-manager|nixos|nixpkgs|nur)
            query="$CAT/ "
            ;;
        all)
            query=""
            ;;
    esac

    # Fetch the packages with nix-search-tv
    packages=$(${gum} spin --spinner points --spinner.foreground 183 \
               --title "Fetching Packages" -- ${ntv} print)

    # Allow user to select the desired package
    selection=$(echo "$packages" \
        | ${fzf} --query "$query" \
            --preview '${ntv} preview {}' \
        | cut -d' ' -f2)

    # Interpret CLI to determine how the selection should be used
    if [ "$CAT" = "nixpkgs" ]; then
        case "$1" in
            shell)
                NIXPKGS_ALLOW_UNFREE=1 nix shell "nixpkgs#$selection" --impure
                ;;
            run)
                NIXPKGS_ALLOW_UNFREE=1 nix run "nixpkgs#$selection" --impure
                ;;
            edit)
                nix edit "nixpkgs#$selection"
                ;;
            homepage)
                nix eval "nixpkgs#''${selection}.meta.homepage" | xargs -I{} xdg-open {}
                ;;
            *)
                echo "$selection"
                ;;
        esac
    else
        echo "$selection"
    fi
  ''
)
