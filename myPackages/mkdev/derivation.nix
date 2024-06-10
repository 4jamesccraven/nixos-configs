{ lib, python3Packages }:

with python3Packages;
buildPythonApplication {
  pname = "mkdev";
  version = "1.2";
  src = pkgs.fetchFromGitHub{
    owner = "4jamesccraven";
    repo = "mkdev";
    rev = "3f30ce14bb6b6ec1f5253404fc8511523d8d58c4";
    sha256 = "0rlfa68vhg71rwa8pmm8l5sq7rcvnwbql9hb42fqq6jgkr0h8bl6";
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