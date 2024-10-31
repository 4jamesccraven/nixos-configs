{ pkgs, ... }:

pkgs.mkShell {
  buildInputs = with pkgs.python312Packages; [
    pkgs.python312
    fastparquet
    ipykernel
    jupyterlab
    jupyterlab-lsp
    matplotlib
    notebook
    numpy
    pandas
    pip
    python-lsp-server
    scikit-learn
    seaborn
    sympy
  ];
 
  shellHook = ''
    clear; zsh; exit
  '';
}
