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
    #-> GUI <-#
    # Internet & Communication #
    brave
    telegram-desktop
    tor-browser-bundle-bin
    # Media #
    foliate
    kdePackages.kdenlive
    obs-studio
    spotify
    vlc
    # Utilities #
    filezilla
    hunspell
    hunspellDicts.en_GB-large
    hunspellDicts.en_US-large
    hunspellDicts.es_ES
    hunspellDicts.es_AR
    libreoffice-qt
    mediawriter
    zenity
    # Games #
    (prismlauncher.override {
      jdks = [
        temurin-bin-8
        temurin-bin-17
        temurin-bin-21
      ];
    })

    #-> CLI <-#
    # Nix CLI Helper #
    inputs.nx.packages.${pkgs.system}.default
    # Coreutils-esque #
    fd
    fzf
    ripgrep
    tealdeer
    # Other Utilities #
    unzip
    zip
    # Fun #
    cowsay
    figlet
    rff-script

    #-> Development <-#
    # Compilers #
    libgcc
    rustc
    # Writing & Presenting #
    texlive.combined.scheme-full
    typst
    # Interpreters #
    python313
    # Project Management #
    cargo
    git
    inputs.mkdev.packages.${pkgs.system}.mkdev
    inputs.mkdev.packages.${pkgs.system}.mkf
    # IDEs #
    vscode
  ];

  #-> Fonts <-#
  fonts.packages = with pkgs; [
    corefonts
    liberation_ttf
    nerd-fonts.fira-code
  ];

  #-> Progam/Service-based packages <-#
  programs.steam.enable = true;
  programs.zsh.enable = true;
}
