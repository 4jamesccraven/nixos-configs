{ pkgs, lib, config, ...}:

{

  home-manager.users.jamescraven = {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;

      defaultEditor = true;

      # Plugins
      plugins = with pkgs.vimPlugins; [
        telescope-nvim
        catppuccin-nvim
      ];

      extraConfig = ''
        colorscheme catppuccin-frappe
      '';

    };
  };

}
