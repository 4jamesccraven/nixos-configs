{ configs, pkgs, ... }:

{
  imports = [
    <home-manager/nixos>
    ../hardware-configuration.nix
    ../modules/git.nix
    ../modules/gnome.nix
    ../myPackages
  ];
  
  system.stateVersion = "23.11";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  ## Network, packages, and users ##

  networking.hostName = "tokoro";
  services.openssh.enable = true;

  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = with pkgs; [
    git
    neovim
    syncthing
  ];

  programs.firefox.enable = true;
  gnome.enable = true;

  users.users.jamescraven = {
    isNormalUser = true;
    description = "James Craven";
    extraGroups = [ "networkmanager" "wheel" ];

    ## Account Specific Software

    packages = with pkgs; [
    ];
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


  ### Sound ###

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

  ## Simplistic bash setup ##
  home-manager.users.jamescraven = {
    programs.bash = {
      enable = true;
      shellAliases = {
        c = "clear";
        build = "sudo nixos-rebuild switch -I nixos-config=$HOME/nixos/configuration.nix";
        clean-and-build = "sudo nix-collect-garbage -d; build";
      };
      bashrcExtra = ''
        PS1="\[\e[38;2;202;158;230m\][\[\e[38;2;231;130;132m\]\u\[\e[38;2;202;158;230m\]@\h] \[\e[38;2;231;130;132m\]\w\n\[\e[38;2;202;158;230m\]$ \[\e[m\]"
      '';
    };

    home.stateVersion = "24.05";
  }; 
}