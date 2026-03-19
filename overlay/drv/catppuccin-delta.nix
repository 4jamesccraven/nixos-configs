{
  pkgs ? import <nixpkgs> { },
  ...
}:

pkgs.stdenvNoCC.mkDerivation {
  pname = "catppuccin-delta";
  version = "2025-10-14";

  src = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "delta";
    rev = "74b47a345638a2f19b3e5bdb9d7e4984066f9ac7";
    hash = "sha256-NjqqB/BHqduiNWKeksiRZUMfjRUodJlsVu1yaEIZRsM=";
  };

  postInstall = ''
    mkdir $out
    cp $src/catppuccin.gitconfig $out
  '';
}
