{ ... }:

/*
  ====[ Machine ]====
  :: trait

  A machine is any system that exists on bare-metal, e.g., Workstations and Servers

  Enables:
      :> System Level
      boot loader    => A computer typically needs one of those
      time/locale    => All machines are in one place
      ssh            => Enabled for all machines
      networkManager => All machines use the internet
*/
{
  imports = [
    ./any.nix
  ];

  # ---[ Boot Loader ]---
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # ---[ Time Zone & Locale ]---
  time.timeZone = "America/New_York";
  i18n =
    let
      locale = "en_US.UTF-8";
    in
    {
      defaultLocale = locale;
      extraLocaleSettings = {
        LC_MESSAGES = locale;
        LC_ADDRESS = locale;
        LC_IDENTIFICATION = locale;
        LC_MEASUREMENT = locale;
        LC_MONETARY = locale;
        LC_NAME = locale;
        LC_NUMERIC = locale;
        LC_PAPER = locale;
        LC_TELEPHONE = locale;
        LC_TIME = locale;
      };
    };

  # ---[ Services ]---
  # :> OpenSSH
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
  };

  # :> Networking
  networking.networkmanager.enable = true;

  # :> Security
  security.sudo = {
    enable = true;
    extraConfig = ''
      Defaults pwfeedback
    '';
  };
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

  # :> Removable Media Management
  services.udisks2.enable = true;
  home-manager.sharedModules = [
    {
      services.udiskie.enable = true;
    }
  ];

  # ---[ Environment Variables ]---
  environment.variables = {
    MOZ_ENABLE_WAYLAND = 0;
    GOPATH = "$HOME/.local/share/go";
  };
}
