{
  pkgs,
  lib,
  inputs,
  ...
}:

/*
  ====[ WSL ]====
  :: trait

  A configuration for the Windows Subsystem for Linux

  Enables
    :> User Level
    dots => some hand-picked dots are available to the wsl config

    :> System Level
    wsl  => the config module provided by the wsl flake
*/
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

  # ---[ WSL ]---
  networking.hostName = "wsl";
  wsl = {
    enable = true;
    defaultUser = "jamescraven";
    wslConf.network.hostname = "wsl";
  };

  # ---[ Software ]---
  environment.systemPackages = with pkgs; [
    just
    nixfmt
    python3
    ripgrep
  ];
  programs.nh.enable = true;
  programs.zsh.enable = true;

  # ---[ Nix Settings ]---
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
