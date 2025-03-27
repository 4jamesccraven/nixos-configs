{ ... }:

{
  home-manager.users.jamescraven = {
    home.file."/home/jamescraven/.config/mkdev/config.toml" = {
      source = ../../assets/mkdev-config.toml;
    };
  };
}
