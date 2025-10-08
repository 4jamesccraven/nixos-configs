{ pkgs, ... }:

# trait Server: Machine {
#     /// A physical machine that is headless, intended to run services
#     dots => A few handpicked dotfiles useful for working on a headless machine;
# }
{
  imports = [
    # Super traits
    ./machine.nix
    # Components
    ../dots/git.nix
    ../dots/lsd.nix
    ../dots/zsh.nix
  ];

  environment.systemPackages = with pkgs; [
    # File management
    dust
    dysk
    yazi
    unzip
    # Tools
    zip
    fd
    ripgrep
    # System management
    git
    just
  ];
  programs.nh.enable = true;
  programs.zsh.enable = true;
}
