{ ... }:

{

  home-manager.users.jamescraven = {
    programs.git = {
      enable = true;
      userName = "4jamesccraven";
      userEmail = "4jamesccraven@gmail.com";

      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };

}
