{ lib, ... }:

# trait Syncthing: Any {
#     /// Indicates that a system should have syncthing enabled.
#     syncthing => File synching service;
# }
{
  services.syncthing =
    let
      makeSharedFolder = name: {
        path = "/home/jamescraven/${name}";
        devices = [
          "RioTinto"
          "tokoro"
          "celebrant"
        ];
      };
    in
    {
      enable = true;
      user = "jamescraven";
      group = "users";
      dataDir = "/home/jamescraven/Documents";
      configDir = "/home/jamescraven/.config/syncthing";
      overrideDevices = true;
      overrideFolders = true;

      settings = {
        devices = {
          RioTinto.id = "JCBOODZ-OZJFDCV-XTV3HDM-YK7CHV6-ZUUNN7E-RO7MGUE-IYFZKRW-BZVSVQZ";
          tokoro.id = "H6VRRS3-IXJ5H2V-6MPLJJS-SGJ2WRD-CJHSDBA-J6FM6Z7-ERKKFB2-27CBFAX";
          celebrant.id = "4C3OPQ6-FDZXVBY-JYJCK4F-EFQCRVJ-XI4NTCJ-BGEQCRO-I5QZVTW-FHA6DQD";
        };

        folders = lib.genAttrs [
          "Audio"
          "Code"
          "Documents"
          "Pictures"
        ] makeSharedFolder;
      };
    };
}
