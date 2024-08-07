{pkgs, ...} :

{
  ### Main account ###
  
  users.users.jamescraven = {
    isNormalUser = true;
    description = "James Craven";
    extraGroups = [ "networkmanager" "wheel" ];

    ## Account Specific Software

    packages = with pkgs; [
      # Recreations/Internet
      spotify
      google-chrome
      telegram-desktop
    ];
  };

  home-manager.users.jamescraven = {...}: {
    home.stateVersion = "24.05";
  };

  ###---------------------------------------------------------------###

  ### la 'fia ###
  users.users.fia = {
    isNormalUser = true;
    description = "fia";
    extraGroups = [ "networkmanager" "wheel" ];

  };
}
