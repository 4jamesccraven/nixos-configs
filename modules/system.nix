{pkgs, lib, config, ...} :

{
  ### Software ###

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    # Terminal Tools
    bat
    btop
    fastfetch
    mkdev
    neovim
    tree

    # Utility
    alacritty
    filezilla
    foliate
    libreoffice-qt
    mediawriter
    tor-browser-bundle-bin

    # Development
    cargo
    git
    libgcc
    python312
    rustc
    texlive.combined.scheme-full
    vscode

    # Theming
    alacritty-theme
    nerdfonts

    # Communication
    discord-screenaudio
    discord # Have both because both have odd quirks.
  
    # Python Packages
    python312Packages.nbformat
    python312Packages.ipykernel
    python312Packages.pip
    python312Packages.numpy
    python312Packages.pandas
    python312Packages.matplotlib
    python312Packages.seaborn
    python312Packages.scikit-learn
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
    # If you want JACK applications, uncomment this
    # jack.enable = true;
  };

  ### DISABLED EXAMPLES ###

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable touchpad support (enabled default in most desktopManger).
  # services.xserver.libinput.enable = true;
}
