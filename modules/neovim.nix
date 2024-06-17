{ pkgs, lib, config, ...}:

{

  home-manager.users.jamescraven = {
    programs.neovim = {
      enable = true;

      defaultEditor = true;

      # Plugins
      plugins = with pkgs.vimPlugins; [
        telescope-nvim
      ];

    };
  };

}
