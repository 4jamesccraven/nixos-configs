{pkgs, lib, ...}: {
    imports = [
      ./alacritty.nix
      ./bash.nix
      ./bat.nix
      ./btop.nix
      ./fastfetch.nix
      ./git.nix
      ./gnome.nix
      ./neovim.nix
      ./system.nix
      ./users.nix
    ];
}
