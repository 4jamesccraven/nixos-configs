{pkgs, lib, ...}: {
    imports = [
      ./modules/system.nix
      ./modules/users.nix
      ./modules/gnome.nix
      ./modules/neovim.nix
      ./modules/fastfetch.nix
      ./modules/alacritty.nix
      ./modules/git.nix
    ];
}
