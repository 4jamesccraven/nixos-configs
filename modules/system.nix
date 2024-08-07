{pkgs, lib, config, ...} :

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
    alacritty-theme
    nerdfonts

    # Communication
    discord-screenaudio
    discord
  ];

  # Progam/Service-based packages
  programs.firefox.enable = true;
  programs.steam.enable = true;

  ### Environment Variables ###
  environment.variables = {
    "MOZ_ENABLE_WAYLAND" = 0;
  };

  ### Generic Sytem Info ###

  # Time Zone
  time.timeZone = "America/New_York";

  # Localisation
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_MESSAGES = "en_US.UTF-8";
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };


  ### Printing & Sound ###

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

}
