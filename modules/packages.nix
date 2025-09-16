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
    makemkv
    obs-studio
    (vlc.override {
      libbluray = libbluray.override {
        withAACS = true;
        withBDplus = true;
      };
    })
    # Office #
    hunspell
    hunspellDicts.en_GB-large
    hunspellDicts.en_US-large
    hunspellDicts.es_ES
    hunspellDicts.es_AR
    libreoffice-qt
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
    ffmpeg-full
    fzf
    tokei
    unzip
    yazi
    zip
    wl-clipboard
    # Fun #
    figlet

    #-> Development <-#
    # Compilers #
    libgcc
    rustc
    # Interpreters #
    python313
    # Writing & Presenting #
    typst
    # Project Management #
    cargo
    git
  ];

  #-> Fonts <-#
  fonts.packages = with pkgs; [
    corefonts
    liberation_ttf
    nerd-fonts.fira-code
  ];

  #-> Progam/Service-based packages <-#
  home-manager.users.jamescraven.programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
  programs.nh.enable = true;
  programs.zsh.enable = true;
  services.blueman.enable = true;
  programs.steam.enable = true;

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
