{ ... }:

{
  home-manager.users.jamescraven =
    let
      ron = ''
        Config(
            nixos_config_dir: "/home/jamescraven/nixos",
        )
      '';
    in
    {
      xdg.configFile."nx/config.ron".text = ron;
    };
}
