{ pkgs, lib, config, ...}:

{
  services.syncthing = {
    enable = true;
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        # "vaal" =     { id = ""; };
        "RioTinto" = { id = "6MRO7HT-VT4Y2WD-POMIEIW-52LCQKX-WDKRXPA-LYHEXFO-EADQ3EX-NIE4MAA"; };
        "tokoro" =   { id = "5ISOJ52-FF6UI25-CF6KSHD-4AMQGSA-A53LJM7-CKFQNNF-YVRZ4X6-EB7NOQP"; };
      };

      folders = {
        "Documents" = {
          path = "~/Documents";
          devices = [ "RioTinto" "tokoro" ];
        };

        "Code" = {
          path = "~/Code";
          devices = [ "RioTinto" "tokoro" ];
        };

        "Pictures" = {
          path = "~/Pictures";
          devices = [ "RioTinto" "tokoro" ];
        };
      };

      gui = {
        user = "jamescraven";
        password = "i-alone-am-the-syncing-one";
      };
    };
  };
}