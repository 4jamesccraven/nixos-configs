{ pkgs, ... }:

{
  ### Software ###

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Terminal Tools
    cowsay
    fd
    figlet
    fzf
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
    telegram-desktop
    tor-browser-bundle-bin
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
    nerdfonts

    # Minecraft
    (prismlauncher.override {
      jdks = [
        temurin-bin-8
        temurin-bin-17
        temurin-bin-21
      ];
    })
  ];

  # Progam/Service-based packages
  programs.steam.enable = true;
  programs.zsh.enable = true;

  virtualisation.docker = {
    enable = true;
  };

}
