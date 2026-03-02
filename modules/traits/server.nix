{ pkgs, ... }:

/*
  ====[ Server ]====
  :: trait

  A physical machine that is headless, intended to run services.

  Enables:
    :> User Level
    dots  => A few handpicked dotfiles useful for working on a headless machine

    :> System Level
    avahi => Allows other machines to find the server via local MDNS
*/
{
  imports = [
    # :> Super traits
    ./machine.nix
    # :> Components
    ../dots/git.nix
    ../dots/lsd.nix
    ../dots/bat.nix
    ../dots/zsh.nix
  ];

  # ---[ Software ]---
  environment.systemPackages = with pkgs; [
    # :> File management
    dust
    dysk
    yazi

    # :> CLI Tools
    fd
    ripgrep
    tor-dl
    zip
    unzip

    # :> System management
    git
    just
  ];
  programs.nh.enable = true;
  programs.zsh.enable = true;

  # ---[ Services ]---
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
