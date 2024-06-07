{pkgs, lib, ...}: {
    imports = [
      ./alacritty.nix
      ./bat.nix
      ./fastfetch.nix
      ./git.nix
      ./gnome.nix
      ./neovim.nix
      ./system.nix
      ./users.nix
    ];
}
