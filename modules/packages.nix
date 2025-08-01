{
  pkgs,
  lib,
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
    # Coreutils-esque #
    du-dust
    dysk
    fd
    just
    ripgrep
    # Other Utilities #
    cava
    ffmpeg
    fselect
    fzf
    tokei
    unzip
    yazi
    zip
    wl-clipboard
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
  services.blueman.enable = true;
  programs.nh.enable = true;
  programs.steam.enable = true;
  programs.zsh.enable = true;

  #-> Cache DevShell Dependencies at Build Time <-#
  system.activationScripts.cacheFlakeShells.text = lib.concatLines (
    lib.flatten (
      map (
        name:
        let
          params = (import ../shells/${name} { inherit pkgs; });
        in
        map (pkg: "echo \"${pkg}\" > /dev/null") params.buildInputs
      ) (builtins.attrNames (builtins.readDir ../shells))
    )
  );
}
