{ ... }:

{
  home-manager.users.jamescraven = {
    programs.zsh = {
      enable = true;

      dirHashes = {
        cd = "$HOME/Code";
        dcs = "$HOME/Documents";
        nix = "$HOME/nixos";
        sw = "$HOME/Documents/Schoolwork";
      };

      initExtra = ''
        zstyle ':completion:*' insert-tab false

        PROMPT='%F{#CA9EE6}┌─[%f/ˈiː.ən/%F{#CA9EE6}@%m]: ❄ %f%~%F{#CA9EE6}
        └─> %f'
        fastfetch
      '';

      shellAliases = {
        c = "clear";
        cat = "bat";
        ff = "fastfetch";
        cff = "clear; fastfetch";
        build = "sudo nixos-rebuild switch --flake /home/jamescraven/nixos";
        clean-and-build = "sudo nix-collect-garbage -d && sudo -u jamescraven nix-collect-garbage -d && build";
      };
    };
  };
}