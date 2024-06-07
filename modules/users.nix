{pkgs, lib, config, ...} :

{
  ### Main account ###
  
  users.users.jamescraven = {
    isNormalUser = true;
    description = "James Craven";
    extraGroups = [ "networkmanager" "wheel" ];

    ## Account Specific Software

    packages = with pkgs; [
      # Recreations/Internet
      discord
      spotify
      google-chrome
      telegram-desktop
    ];
  };

  home-manager.users.jamescraven = {pkgs, ...}: {
    home.stateVersion = "24.05";

    # Set up Bash Aliases
    programs.bash = {
      enable = true;
      shellAliases = {
        c = "clear";
        cat = "bat";
        cff = "clear; fastfetch";
        ff = "fastfetch";
        build = "sudo nixos-rebuild switch -I nixos-config=$HOME/nixos/configuration.nix";
        clean-and-build = "sudo nix-collect-garbage -d; build";
      };
      bashrcExtra = ''
        fastfetch
        PS1='\[\e[38;2;202;158;230m\][\u@\h:\w] $\[\e[m\]' 
      '';
    };
  };

  ###---------------------------------------------------------------###

  ### la 'fia ###
  users.users.fia = {
    isNormalUser = true;
    description = "fia";
    extraGroups = [ "networkmanager" "wheel" ];

    ## Account Specific Software

    packages = with pkgs; [
      discord
    ];
  };
}
