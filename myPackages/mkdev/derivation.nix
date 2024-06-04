{ lib, python3Packages }:

with python3Packages;
buildPythonApplication {
  pname = "mkdev";
  version = "1.0";
  src = ./src;

  postInstall = ''
    mv -v $out/bin/mkdev.py $out/bin/mkdev
  '';
}