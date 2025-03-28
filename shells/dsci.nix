# CACHE
{ pkgs, ... }:

pkgs.mkShell {
  buildInputs = with pkgs.python313Packages; [
    pkgs.python313
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
}
