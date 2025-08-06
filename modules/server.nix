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
    ./dots/kitty.nix
    ./dots/lsd.nix
    ./dots/neovim
    ./syncthing.nix
    ./system.nix
  ];

  gnome.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    just
    kitty
    git
    ripgrep
    fd
    ffmpeg
  ];
  programs.firefox.enable = true;
  programs.nh.enable = true;
  programs.zsh.enable = true;

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

  home-manager.users.jamescraven = {
    programs.zsh = {
      enable = true;

      dirHashes = {
        dw = "$HOME/Downloads";
        cd = "$HOME/Code";
        nix = "$HOME/nixos";
      };

      initContent = # bash
        ''
          zstyle ':completion:*' insert-tab false

          setopt auto_param_slash  # Dirs are autocompleted with a trailing /
          setopt cdable_vars       # Try to prepend ~ if a cd command fails
          setopt cd_silent         # Don't pwd after cd
          setopt correct           # Offer to correct mispelled commands

          PROMPT='%F{red}╭─(%f/ˈiː.ən/%F{red}@%m): [%f%~%F{red}]
          ╰─❯ %f'
        '';

      shellAliases = {
        c = "clear";
        j = "just";
        ## Git
        ga = "git add . --all";
        gc = "git clone";
        gcm = "git commit";
        gd = "git diff ':!*lock'";
        gdf = "git diff";
        gds = "git diff --stat";
        gi = "git init";
        gl = "git log";
        gp = "git push origin HEAD";
        gs = "git status";
        gu = "git pull";
        gr = "git rev-parse --show-toplevel";
        ggr = "cd $(git rev-parse --show-toplevel)";
        gitaliases = "alias | grep git | grep -v gitaliases | sed 's/ *= */ = /' | column -t -s=";
      };
    };

    home.stateVersion = "24.05";
  };
}
