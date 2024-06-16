{ lib, pkgs, ... }:

pkgs.stdenvNoCC.mkDerivation {
  pname = "dracula-cursors";
  version = "4.0.0";
  src = pkgs.fetchFromGitHub {
    owner = "dracula";
    repo = "gtk";
    rev = "4a5fe924a2b17f82a617f79ef661f1783cacc988";
    sha256 = "1vx0fkign3rlpp73sv63jwqnblw73nanrb5895jk0kf91ng28g3b";
  };
      
  postInstall = ''
    mkdir -p $out/share/icons
    cp -r $src/kde/cursors/Dracula-cursors $out/share/icons/
  '';
}