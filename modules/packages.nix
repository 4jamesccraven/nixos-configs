{ pkgs, ... }:

{
  ### Software ###

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Terminal Tools
    mkdev
    tree

    # Utility
    filezilla
    foliate
    libreoffice-qt
    mediawriter
    tor-browser-bundle-bin

    # Development
    cargo
    git
    libgcc
    rustc
    texlive.combined.scheme-full
    vscode
    python312

    # Theming
    nerdfonts
  ];

  # Progam/Service-based packages
  programs.firefox.enable = true;
  programs.steam.enable = true;

}
