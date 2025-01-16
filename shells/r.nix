{ pkgs, ... }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    R
    rstudio
  ];

  shellHook = ''
    clear; zsh; exit
  '';
}
