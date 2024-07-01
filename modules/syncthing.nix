{ pkgs, lib, config, ...}:

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
        "vaal" =     { id = "HVZXSAY-3P5YHIN-OO4L3PS-JSKEWV3-CS7MYTK-K5I5VAQ-7ISIYXW-PQ56HQN"; };
        "RioTinto" = { id = "JCBOODZ-OZJFDCV-XTV3HDM-YK7CHV6-ZUUNN7E-RO7MGUE-IYFZKRW-BZVSVQZ"; };
        "tokoro" =   { id = "KAV5MFS-KB4WA37-IOLIUCT-46LU5UG-Z7NEXX4-QNHUP3I-6TZFN36-VYYPIAD"; };
      };

      folders = {
        "Documents" = {
          path = "/home/jamescraven/Documents";
          devices = [ "RioTinto" "tokoro" "vaal" ];
        };

        "Code" = {
          path = "/home/jamescraven/Code";
          devices = [ "RioTinto" "tokoro" "vaal" ];
        };

        "Pictures" = {
          path = "/home/jamescraven/Pictures";
          devices = [ "RioTinto" "tokoro" "vaal" ];
        };
      };

      gui = {
        user = "jamescraven";
        password = "i-alone-am-the-syncing-one";
      };
    };
  };
}
