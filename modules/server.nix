{ pkgs, inputs, ...}:

{
  imports = [
    inputs.home-manager.nixosModules.default
    ./desktop-environment
    ./dots/kitty.nix
    ./dots/git.nix
    ./syncthing.nix
    ./system.nix
    ../myPackages
  ];

  gnome.enable = true;

  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = with pkgs; [
    kitty
    git
    neovim
  ];
  programs.firefox.enable = true;

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
  };

  users.users.jamescraven = {
    isNormalUser = true;
    description = "James Craven";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager.users.jamescraven = {
    programs.bash = {
      enable = true;
      shellAliases = {
        c = "clear";
        build = "sudo nixos-rebuild switch --flake /home/jamescraven/nixos";
        clean-and-build = "sudo nix-collect-garbage -d && build";
      };
      bashrcExtra = ''
        PS1="\[\e[38;2;202;158;230m\]┌─[\[\e[38;2;231;130;132m\]/ˈiː.ən/\[\e[38;2;202;158;230m\]@\h]:  \[\e[38;2;231;130;132m\]\w\n\[\e[38;2;202;158;230m\]└─󰊜 \[\e[m\]"
      '';
    };

    home.stateVersion = "24.05";
  }; 
}
