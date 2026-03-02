{ pkgs, ... }:

{
  buildInputs = with pkgs.python314Packages; [
    pkgs.python314
    fastparquet
    ipykernel
    jupyterlab
    jupyterlab-lsp
    marimo
    matplotlib
    notebook
    numpy
    pandas
    pip
    python-lsp-server
    rich
    scikit-learn
    seaborn
    sympy
    tqdm
  ];
}
