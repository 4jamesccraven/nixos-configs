{ pkgs, inputs, system, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
    ./desktop-environment
    ./dots/git.nix
    ./dots/kitty.nix
    ./dots/neovim.nix
    ./syncthing.nix
    ./system.nix
    ../custom-derivations
  ];

  gnome.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    nx

    kitty
    git
    neovim
  ];
  programs.firefox.enable = true;
  programs.zsh.enable = true;

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
  };

  systemd.services.wf-bot = {
    description = "Warframe Discord bot";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      EnvironmentFile = "/home/jamescraven/.config/wf-bot/.env";
      ExecStart = "${inputs.wf-bot.packages.${system}.default}/bin/wf-bot";
      Restart = "always";
    };
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
        build = "sudo nixos-rebuild switch --flake /home/jamescraven/nixos";
        clean-and-build = "sudo nix-collect-garbage -d && sudo -u jamescraven nix-collect-garbage -d && build";
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

      initExtra = ''
        zstyle ':completion:*' insert-tab false

        PROMPT='%F{red}╭─(%f/ˈiː.ən/%F{red}@%m): [%f%~%F{red}]
        ╰─❯ %f'
      '';

      shellAliases = {
        c = "clear";
        build = "sudo nixos-rebuild switch --flake /home/jamescraven/nixos";
        clean-and-build = "sudo nix-collect-garbage -d && sudo -u jamescraven nix-collect-garbage -d && build";
      };
    };

    home.stateVersion = "24.05";
  };
}
