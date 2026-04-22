{ pkgs, lib, ... }:

/*
  ====[ XDG Desktop Entries ]====
  :: in trait `Workstation`
  A set of XDG Desktop entries to be used with application launchers (e.g., Fuzzel).
*/
let
  vlc = lib.getExe pkgs.vlc;

  mkEntry =
    {
      n,
      name,
      url ? null,
    }:
    let
      camNumber = lib.toString n;
      stream = if url != null then url else "rtsp://cams:855${camNumber}/cam${camNumber}";
    in
    pkgs.makeDesktopItem {
      name = "cam${camNumber}";
      desktopName = "cam${camNumber} (${name})";
      exec = "${vlc} --no-qt-error-dialogs --qt-minimal-view \"--key-play-pause=\" \"--key-pause=\" ${stream}";
      icon = "accessories-camera";
      categories = [ "Network" ];
    };

  camNames = [
    "Driveway"
    "Backyard"
  ];
  systemPackages = lib.pipe camNames [
    (lib.imap1 (n: name: { inherit n name; }))
    (map mkEntry)
  ];
in
{
  environment = { inherit systemPackages; };
}
