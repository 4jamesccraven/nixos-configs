{ lib, python3Packages }:

with python3Packages;
buildPythonApplication {
  pname = "mkdev";
  version = "1.2";
  src = pkgs.fetchFromGitHub{
    owner = "4jamesccraven";
    repo = "mkdev";
    rev = "244d85f3c6b95d90bde92e5a1f4f23e93e7ad80e";
    sha256 = "05idggddwv7sa42pqm1zglvvj0mr2z0fpivi0pwyj1hwifsa056i";
  };

  buildInputs = [ python ];

  propagatedBuildInputs = [
    platformdirs
    pyyaml
  ];

  postInstall = ''
    sed -i '1i#!/usr/bin/env python3' $out/bin/mkdev.py
    mv -v $out/bin/mkdev.py $out/bin/mkdev
    cp -r $src/config $out/bin/config
  '';
}