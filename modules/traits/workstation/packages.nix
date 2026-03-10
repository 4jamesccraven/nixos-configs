{
  pkgs,
  ...
}:

/*
  ====[ Packages ]====
  :: in trait `Workstation`
  The master package list for all general purpose workstation.

  Enables:
  - Browsers, Office Suite, Media, etc.
  - Fonts
  - Man caching
*/
{
  environment.systemPackages = with pkgs; [
    # ---[ GUI ]---
    # :> Internet & Communication
    # keep-sorted start
    brave
    telegram-desktop
    tor-browser
    # keep-sorted end

    # :> Media
    # keep-sorted start
    foliate
    makemkv
    obs-studio
    vlc
    # keep-sorted end

    # :> Office
    # keep-sorted start
    hunspell
    hunspellDicts.en_GB-large
    hunspellDicts.en_US-large
    hunspellDicts.es_AR
    hunspellDicts.es_ES
    libreoffice-qt
    # keep-sorted end

    # :> Music
    # keep-sorted start
    ardour
    musescore
    # keep-sorted end

    # :> Games
    (prismlauncher.override {
      jdks = [
        temurin-bin-8
        temurin-bin-17
        temurin-bin-21
      ];
    })

    # ---[ CLI ]---
    # :> Coreutils-esque
    # keep-sorted start
    dust
    dysk
    fd
    just
    ripgrep
    # keep-sorted end

    # :> Other Utilities
    # keep-sorted start
    caligula
    ffmpeg-full
    file
    fzf
    tokei
    tor-dl
    unzip
    wl-clipboard
    yazi
    yt-dlp
    zip
    # keep-sorted end

    # :> Fun
    figlet

    # :> Scripts
    # keep-sorted start
    ns
    update-notify
    # keep-sorted end

    # ---[ Development ]---
    # :> Compilers
    # keep-sorted start
    libgcc
    rustc
    # keep-sorted end

    # :> Interpreters
    python314

    # :> Writing & Presenting
    # keep-sorted start
    typst
    typstyle
    # keep-sorted end

    # :> Project Management
    # keep-sorted start
    cargo
    gh
    git
    # keep-sorted end
  ];

  # ---[ Progam/Service-based ]---
  programs = {
    nh.enable = true;
    zsh.enable = true;
    direnv = {
      enable = true;
      loadInNixShell = true;
      nix-direnv.enable = true;
    };
  };
  services.blueman.enable = true;

  # ---[ Fonts ]---
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      corefonts
      liberation_ttf
      nerd-fonts.fira-code
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];
    fontconfig.defaultFonts = {
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
    };
  };

  # ---[ man ]---
  documentation.man = {
    enable = true;
    cache.enable = true;
  };

}
