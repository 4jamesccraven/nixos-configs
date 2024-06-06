{ lib, python3Packages }:

with python3Packages;
buildPythonApplication {
  pname = "mkdev";
  version = "1.1";
  src = pkgs.fetchFromGitHub{
    owner = "4jamesccraven";
    repo = "mkdev";
    rev = "02b03f7de8b7a6992c53da31adc75d82a0f92565";
    sha256 = "0892rkcwf2zjrp85qc36348bx013zl2vy3g2v1vf0cr9bn6794a0";
  };

  buildInputs = [ python ];

  propagatedBuildInputs = [
    pyyaml
    platformdirs
  ];

  postInstall = ''
    sed -i '1i#!/usr/bin/env python3' $out/bin/mkdev.py
    mv -v $out/bin/mkdev.py $out/bin/mkdev
    cp -r $src/config $out/bin/config
  '';
}