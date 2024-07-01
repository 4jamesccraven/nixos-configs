{ pkgs, lib, config, ...}:

{
  services.syncthing = {
    enable = true;
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "vaal" =     { id = "HVZXSAY-3P5YHIN-OO4L3PS-JSKEWV3-CS7MYTK-K5I5VAQ-7ISIYXW-PQ56HQN"; };
        "RioTinto" = { id = "6MRO7HT-VT4Y2WD-POMIEIW-52LCQKX-WDKRXPA-LYHEXFO-EADQ3EX-NIE4MAA"; };
        "tokoro" =   { id = "KAV5MFS-KB4WA37-IOLIUCT-46LU5UG-Z7NEXX4-QNHUP3I-6TZFN36-VYYPIAD"; };
      };

      folders = {
        "Documents" = {
          path = "~/Documents";
          devices = [ "RioTinto" "tokoro" "vaal" ];
        };

        "Code" = {
          path = "~/Code";
          devices = [ "RioTinto" "tokoro" "vaal" ];
        };

        "Pictures" = {
          path = "~/Pictures";
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
