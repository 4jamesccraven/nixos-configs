{ pkgs, ... }:

# trait Server: Machine {
#     /// A physical machine that is headless, intended to run services
#     dots  => A few handpicked dotfiles useful for working on a headless machine;
#     avahi => Allows Windows (ew) to find the server via local MDNS;
# }
{
  imports = [
    # Super traits
    ./machine.nix
    # Components
    ../dots/git.nix
    ../dots/lsd.nix
    ../dots/bat.nix
    ../dots/zsh.nix
  ];

  environment.systemPackages = with pkgs; [
    # File management
    dust
    dysk
    unzip
    yazi
    # Tools
    fd
    ripgrep
    tor-dl
    zip
    # System management
    git
    just
  ];
  programs.nh.enable = true;
  programs.zsh.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    ipv6 = false;

    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };

    extraConfig = /* ini */ ''
      [publish]
      publish-a-on-ipv6=yes
    '';
  };
}
