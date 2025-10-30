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
          "vaal"
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
          vaal.id = "R4GJ6P7-6JKQES7-WU3M3RH-G4EQBM3-C5MKBDG-UYI5ISG-OITEZPH-XUVCFAP";
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
