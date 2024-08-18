{ pkgs, ... }:

{
  ### Software ###

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Terminal Tools
    mkdev
    ripgrep
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
  programs.firefox.enable = true;
  programs.steam.enable = true;

}
