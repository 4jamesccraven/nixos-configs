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

      coc = {
        # Code auto-complete
        settings = {
          enable = true;
          
          languageserver = {
            # Nix language support
            nixd = {
              command = "nixd";
              rootPatterns = [ ".nixd.json" ];
              filetypes = [ "nix" ];
            };
          };
        };
      };

    };
  };
}
