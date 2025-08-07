{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.home-manager.nixosModules.default
    inputs.wf-bot.nixosModules.default
    ../overlay
    ./colors.nix
    ./desktop-environment
    ./dots/git.nix
    ./dots/lsd.nix
    ./dots/neovim
    ./dots/zsh.nix
    ./syncthing.nix
    ./system.nix
  ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    just
    git
    ripgrep
    fd
    ffmpeg
    dysk
    dust
    yazi
  ];
  programs.firefox.enable = true;
  programs.nh.enable = true;

  services = {
    openssh = {
      enable = true;
      settings.PermitRootLogin = "no";
    };

    wf-bot = {
      enable = true;
      EnvironmentFile = "/home/jamescraven/.config/wf-bot/.env";
    };

    jellyfin = {
      enable = true;
    };
  };

  networking.firewall.allowedTCPPorts = [ 8096 ];

  users.users.jamescraven = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "James Craven";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  home-manager.users.jamescraven.home.stateVersion = "24.05";
}
