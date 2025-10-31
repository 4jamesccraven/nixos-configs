{ ... }:

# trait Workstation: Graphical + Syncthing + Virtualisation {
#     /// A full-featured, physical workstation that has a graphical environment
#     // User-Level
#     dots       => Full set of dotfiles for all tools;
#     synchthing => File syncing;
#     packages   => All of the packages that any workstation should have;
#
#     // System level
#     users      => Definition of my user account. todo!() restructure, users probably shouldn't be so hardcoded;
#     daemons    => Daemons that control things only necessary for workstations.
# }
{
  imports = [
    # Super Traits
    ../graphical
    ../syncthing.nix
    ../virtualisation.nix
    # Contents
    ./packages.nix
    ./desktop-entries.nix
    ../../dots
  ];

  # Daemons
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
      jack.enable = true;
      wireplumber.enable = true;
    };
  };

  # This is pipewire related ¯\_(ツ)_/¯
  security.rtkit.enable = true;

  hardware.bluetooth.enable = true;
}
