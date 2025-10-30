{ ... }:

# trait Machine: Any {
#     /// A machine is any system that exists on bare-metal, e.g., Workstations and Servers
#     boot loader    => A computer typically needs one of those;
#     time/locale    => All machines are in one place;
#     ssh            => Enabled for all machines;
#     networkManager => All machines use the internet;
# }
{
  imports = [
    ./any.nix
  ];

  ### Boot Loader ###
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  ### Environment Variables ###
  environment.variables = {
    MOZ_ENABLE_WAYLAND = 0;
    GOPATH = "$HOME/.local/share/go";
  };

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

  ### Services ###
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
  };

  # Networking
  networking.networkmanager.enable = true;

  # Allow users to power-off the system etc.
  security.polkit.extraConfig = /* js */ ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("wheel")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    });
  '';

  # Removable media
  services.udisks2.enable = true;
  home-manager.sharedModules = [
    {
      services.udiskie.enable = true;
    }
  ];
}
