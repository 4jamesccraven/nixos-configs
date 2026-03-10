{ ... }:

/*
  ====[ Workstation ]====
  :: trait

  A full-featured, physical workstation that has a graphical environment.

  Enables:
    :> User Level
    dots       => Full set of dotfiles for all tools
    synchthing => File syncing
    packages   => All of the packages that any workstation should have

    :> System level
    users      => Definition of my user account
    daemons    => Daemons that control things only necessary for workstations
*/
{
  imports = [
    # :> Super Traits
    # keep-sorted start
    ../graphical
    ../syncthing.nix
    ../virtualisation.nix
    # keep-sorted end
    # :> Contents
    # keep-sorted start
    ../../dots
    ./desktop-entries.nix
    ./packages.nix
    # keep-sorted end
  ];

  # ---[ Daemons ]---
  # :> CUPS
  services.printing.enable = true;

  # :> Bluetooth
  hardware.bluetooth.enable = true;
}
