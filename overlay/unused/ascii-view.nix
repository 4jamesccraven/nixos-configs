{
  pkgs ? import <nixpkgs> { },
  ...
}:

pkgs.stdenv.mkDerivation {
  pname = "ascii-view";
  version = "20251016";

  src = pkgs.fetchFromGitHub {
    owner = "gouwsxander";
    repo = "ascii-view";
    rev = "9547fb51dd9d0eea1d9450e79a51bb7e7057ea94";
    hash = "sha256-fLQQExRbf/gD6bCKETvEED71DZZuwOUZHdpEqXlrpeo=";
  };

  buildPhase = ''
    make release
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv ./ascii-view $out/bin
    chmod +x $out/bin/ascii-view
  '';
}
