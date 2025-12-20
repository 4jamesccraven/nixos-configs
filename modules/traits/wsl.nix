{
  pkgs,
  lib,
  inputs,
  ...
}:

# trait WSL: Any {
#     /// A configuration for the Windows Subsystem for Linux
#     dots => some hand-picked dots are available to the wsl config;
#     wsl  => the config module provided by the wsl flake;
# }
{
  imports = [
    ./any.nix
    ../dots/bat.nix
    ../dots/fastfetch.nix
    ../dots/git.nix
    ../dots/lsd.nix
    ../dots/starship.nix
    ../dots/tealdeer.nix
    ../dots/zsh.nix
    inputs.nixos-wsl.nixosModules.default
  ];

  # WSL-specific config.
  networking.hostName = "wsl";
  wsl = {
    enable = true;
    defaultUser = "jamescraven";
    wslConf.network.hostname = "wsl";
  };

  # Extra software
  environment.systemPackages = with pkgs; [
    just
    nixfmt-rfc-style
    python3
    ripgrep
  ];
  programs.nh.enable = true;
  programs.zsh.enable = true;

  # Nix info
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
