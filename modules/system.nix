{pkgs, lib, config, ...} : {

  ### Software ###

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    # Terminal Tools
    neovim
    fastfetch
    tree

    # Utility
    alacritty
    tor-browser-bundle-bin
    libreoffice-qt
    filezilla

    # Development
    python3
    vscode
    texlive.combined.scheme-full
    nixd
    libgcc
    git
    git-credential-manager

    # Theming
    alacritty-theme
    nerdfonts
  ];

  # Progam/Service-based packages
  services.blueman.enable = true;
  programs.steam.enable = true;
  programs.firefox.enable = true;


  ### Bootloader. ###

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  ### Generic Sytem Info ###

  # Computer Name
  networking.hostName = "vaal";

  # Time Zone
  time.timeZone = "America/New_York";

  # Localisation
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_MESSAGES = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };


  ### Printing & Sound ###

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
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
