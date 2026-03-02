{
  inputs,
  pkgs,
  ...
}:

/*
  ====[ Neovim ]====
  :: trait

  Neovim, my goat <3
  For the actual config, see https://github.com/4jamesccraven/neovim.

  Enables:
    :> User Level
    aliases => symlinks vi{,m} to nvim
    lsp     => installs a bunch of lsps referenced by my config
    plugins => installs the plugins necessary for my config
*/
{
  environment.sessionVariables.EDITOR = "nvim";

  home-manager.users.jamescraven = {
    programs.neovim = {

      # ---[ Aliases etc. ]----
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;

      # ---[ Additional Software ]---
      plugins = inputs.jcc-neovim.pluginList.${pkgs.stdenv.hostPlatform.system};

      # note: these are only available to nvim itself; they are not on the system path.
      extraPackages = with pkgs; [
        # :> LSP
        clang-tools
        lua-language-server
        nixd
        nixfmt
        pyright
        rust-analyzer
        rustfmt
        tinymist

        # :> Clipboard support
        xclip
        wl-clipboard
      ];
    };
  };

}
