{ pkgs, inputs, ... }:

{
  imports = [
    ../custom-derivations
    ./colors.nix
    ./dots/bat.nix
    ./dots/fastfetch.nix
    ./dots/git.nix
    ./dots/lsd.nix
    ./dots/neovim.nix
    ./dots/starship.nix
    ./dots/zsh.nix
  ];

  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style
    inputs.nx.packages.${system}.default
    python3
    ripgrep
  ];

  programs.zsh.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  home-manager.users.jamescraven = {
    home.stateVersion = "24.05";
  };
}
