{ pkgs, ... }:

{
  buildInputs = with pkgs.python313Packages; [
    pkgs.python313
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
    tqdm
    scikit-learn
    seaborn
    sympy
  ];
}
