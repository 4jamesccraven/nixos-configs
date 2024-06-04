{pkgs, lib, ...}: {
    imports = [
      ./system.nix
      ./users.nix
      ./gnome.nix
      ./neovim.nix
      ./fastfetch.nix
      ./alacritty.nix
      ./git.nix
    ];
}
