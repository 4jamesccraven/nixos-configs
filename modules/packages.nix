{ pkgs, inputs, system, ... }:

{
  ### Software ###

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # nix cli
    nx

    # Terminal Tools
    cowsay
    fd
    figlet
    fzf
    inputs.mkdev.packages.${system}.mkdev
    nixfmt-rfc-style
    rff-script
    ripgrep
    tree
    unzip
    zip

    # Utility
    brave
    filezilla
    foliate
    libreoffice-qt
    mediawriter
    spotify
    tealdeer
    telegram-desktop
    tor-browser-bundle-bin
    vlc
    zenity

    # Development
    cargo
    git
    libgcc
    python312
    rustc
    texlive.combined.scheme-full
    vscode

    # Theming
    nerd-fonts.fira-code
  ];

  # Progam/Service-based packages
  programs.steam.enable = true;
  programs.zsh.enable = true;

  virtualisation.docker = {
    enable = true;
  };

}
