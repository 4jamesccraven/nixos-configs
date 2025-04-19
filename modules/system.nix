{ ... }:

{
  ### Boot Loader ###
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  ### Environment Variables ###
  environment.variables = {
    "MOZ_ENABLE_WAYLAND" = 0;
  };

  system.stateVersion = "23.11";

  # Time Zone
  time.timeZone = "America/New_York";

  # Localisation
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };

  ### Printing & Sound ###

  services = {
    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Enable the openssh Daemon
    openssh = {
      enable = true;
      settings.PermitRootLogin = "no";
    };
  };

  security.rtkit.enable = true;

  ### Generic Sytem Info ###
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
