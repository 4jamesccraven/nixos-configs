{
  pkgs,
  inputs,
  ...
}:

{
  ### Software ###

  imports = [
    ./virtualisation.nix
  ];

  nixpkgs.config.allowUnfree = true;

  documentation.man = {
    enable = true;
    generateCaches = true;
  };

  environment.systemPackages = with pkgs; [
    # nix cli
    inputs.nx.packages.${pkgs.system}.default

    # Terminal Tools
    cowsay
    fd
    figlet
    fzf
    inputs.mkdev.packages.${pkgs.system}.mkdev
    inputs.mkdev.packages.${pkgs.system}.mkf
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
    obs-studio
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
    python313
    rustc
    texlive.combined.scheme-full
    vscode

    # Minecraft
    (prismlauncher.override {
      jdks = [
        temurin-bin-8
        temurin-bin-17
        temurin-bin-21
      ];
    })
  ];

  fonts.packages = with pkgs; [
    corefonts
    liberation_ttf
    nerd-fonts.fira-code
  ];

  # Progam/Service-based packages
  programs.steam.enable = true;
  programs.zsh.enable = true;
}
