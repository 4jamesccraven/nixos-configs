{ pkgs, ... }:

{
  imports = [
    ./colors.nix
    ./dots/bat.nix
    ./dots/fastfetch.nix
    ./dots/git.nix
    ./dots/lsd.nix
    ./dots/neovim
    ./dots/starship.nix
    ./dots/zsh.nix
    ../overlay
  ];

  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style
    python3
    ripgrep
    just
  ];

  programs.nh.enable = true;
  programs.zsh.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  home-manager.users.jamescraven = {
    home.stateVersion = "24.05";
  };
}
