{ ... }:

{
  home-manager.users.jamescraven = {
    home.file."/home/jamescraven/.config/mkdev/config.toml" = {
      source = ./mkdev-config.toml;
    };
  };
}
