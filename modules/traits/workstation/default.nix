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
    ../graphical
    ../syncthing.nix
    ../virtualisation.nix
    # :> Contents
    ./packages.nix
    ./desktop-entries.nix
    ../../dots
  ];

  # ---[ Daemons ]---
  # :> CUPS
  services.printing.enable = true;

  # :> Bluetooth
  hardware.bluetooth.enable = true;
}
