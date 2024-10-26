{ ... }:

{
  services.syncthing = {
    enable = true;
    user = "jamescraven";
    dataDir = "/home/jamescraven/Documents";
    configDir = "/home/jamescraven/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "vaal" = {
          id = "D7HEMFA-4567NUZ-G46VZNP-NMLLUM2-56LVU7Z-OKZBCL3-ZNAXQYK-3RQFOAJ";
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
