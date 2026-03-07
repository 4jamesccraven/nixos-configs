{ lib, ... }:

/*
  ====[ Constants/Shell Aliases ]====

  These are my shell aliases, abstracted away for use in any shell.
*/
let
  inherit (lib) mkOption types;
in
{
  options.ext.shell-aliases = mkOption {
    type = types.attrsOf (types.str);
    description = "Shell aliases for use in shell configurations.";
  };

  config.ext.shell-aliases = {
    # :> Abbreviations
    c = "clear";
    cff = "clear; fastfetch";
    ff = "fastfetch";
    j = "just";
    s = "ssh";
    y = "yazi";

    # :> Git
    ga = "git add . --all";
    gc = "git clone";
    gcm = "git commit";
    gd = "git diff HEAD ':!*lock'";
    gdf = "git diff";
    gds = "git diff --stat";
    gi = "git init";
    gl = "git log --stat";
    glf = "git log";
    gp = "git push origin HEAD";
    gs = "git status";
    gu = "git pull";
    gr = "git rev-parse --show-toplevel";
    ggr = "cd $(git rev-parse --show-toplevel)";
    gitaliases = "alias | grep git | grep -v gitaliases | sed 's/ *= */ = /' | column -t -s=";

    # :> Tools
    pcalc = "nix develop $HOME/nixos#dsci -c python";
    nohist = "HISTFILE= bash";
  };
}
