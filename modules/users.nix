{ pkgs, ... } :

{
  ### Main account ###
  
  users.users.jamescraven = {
    isNormalUser = true;
    description = "James Craven";
    extraGroups = [ "networkmanager" "wheel" ];

    ## Account Specific Software

    packages = with pkgs; [
      spotify
      google-chrome
      telegram-desktop
    ];
  };

  home-manager.users.jamescraven = {...}: {
    home.stateVersion = "24.05";
  };

  users.users.fia = {
    isNormalUser = true;
    description = "fia";
    extraGroups = [ "networkmanager" "wheel" ];

  };
}
