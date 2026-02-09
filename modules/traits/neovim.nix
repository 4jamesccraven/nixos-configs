{
  inputs,
  pkgs,
  ...
}:

{
  environment.sessionVariables.EDITOR = "nvim";

  home-manager.users.jamescraven = {
    programs.neovim = {

      extraPackages = with pkgs; [
        # LSP
        clang-tools
        nixd
        nixfmt
        pyright
        python313Packages.autopep8
        rust-analyzer
        rustfmt
        tinymist

        # Clipboard support
        xclip
        wl-clipboard
      ];

      enable = true;
      viAlias = true;
      vimAlias = true;

      defaultEditor = true;

      plugins = inputs.jcc-neovim.pluginList.${pkgs.stdenv.hostPlatform.system};
    };
  };

}
