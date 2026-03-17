{ ... }:

/*
  ====[ Dots ]====
  :: module library

  Dotfiles for several programs managed by home-manager.
*/
{
  imports = [
    # keep-sorted start
    ./bash.nix
    ./bat.nix
    ./btop.nix
    ./fastfetch.nix
    ./git.nix
    ./gtk.nix
    ./kitty.nix
    ./lsd.nix
    ./mkdev.nix
    ./starship.nix
    ./tealdeer.nix
    ./zsh.nix
    # keep-sorted end
  ];
}
