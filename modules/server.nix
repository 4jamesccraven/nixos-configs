{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.home-manager.nixosModules.default
    inputs.wf-bot.nixosModules.default
    ./colors.nix
    ./desktop-environment
    ./dots/git.nix
    ./dots/kitty.nix
    ./dots/neovim
    ./dots/nx.nix
    ./syncthing.nix
    ./system.nix
    ../overlay
  ];

  gnome.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    just
    kitty
    git
    neovim
  ];
  programs.firefox.enable = true;
  programs.nh.enable = true;
  programs.zsh.enable = true;

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
  };

  services.wf-bot = {
    enable = true;
    EnvironmentFile = "/home/jamescraven/.config/wf-bot/.env";
  };

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
    programs.bash = {
      enable = true;
      shellAliases = {
        c = "clear";
      };
      bashrcExtra = ''
        PS1="\[\e[38;2;202;158;230m\]┌─[\[\e[38;2;231;130;132m\]/ˈiː.ən/\[\e[38;2;202;158;230m\]@\h]: ❄ \[\e[38;2;231;130;132m\]\w\n\[\e[38;2;202;158;230m\]└─󰊜 \[\e[m\]"
      '';
    };

    programs.zsh = {
      enable = true;

      dirHashes = {
        cd = "$HOME/Code";
        dcs = "$HOME/Documents";
        nix = "$HOME/nixos";
        sw = "$HOME/Documents/Schoolwork";
      };

      initContent = ''
        zstyle ':completion:*' insert-tab false

        PROMPT='%F{red}╭─(%f/ˈiː.ən/%F{red}@%m): [%f%~%F{red}]
        ╰─❯ %f'
      '';

      shellAliases = {
        c = "clear";
      };
    };

    home.stateVersion = "24.05";
  };
}
