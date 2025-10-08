{ ... }:

# trait Syncthing: Any {
#     /// Indicates that a system should have syncthing enabled.
#     syncthing => File synching service;
# }
{
  services.syncthing = {
    enable = true;
    user = "jamescraven";
    group = "users";
    dataDir = "/home/jamescraven/Documents";
    configDir = "/home/jamescraven/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "vaal" = {
          id = "R4GJ6P7-6JKQES7-WU3M3RH-G4EQBM3-C5MKBDG-UYI5ISG-OITEZPH-XUVCFAP";
        };
        "RioTinto" = {
          id = "JCBOODZ-OZJFDCV-XTV3HDM-YK7CHV6-ZUUNN7E-RO7MGUE-IYFZKRW-BZVSVQZ";
        };
        "tokoro" = {
          id = "H6VRRS3-IXJ5H2V-6MPLJJS-SGJ2WRD-CJHSDBA-J6FM6Z7-ERKKFB2-27CBFAX";
        };
      };

      folders = {
        "Documents" = {
          path = "/home/jamescraven/Documents";
          devices = [
            "RioTinto"
            "tokoro"
            "vaal"
          ];
        };

        "Code" = {
          path = "/home/jamescraven/Code";
          devices = [
            "RioTinto"
            "tokoro"
            "vaal"
          ];
        };

        "Pictures" = {
          path = "/home/jamescraven/Pictures";
          devices = [
            "RioTinto"
            "tokoro"
            "vaal"
          ];
        };
      };
    };
  };
}
