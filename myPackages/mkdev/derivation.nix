{ lib, python312Packages }:

with python312Packages;
buildPythonApplication {
  pname = "mkdev";
  version = "2.0";
  src = pkgs.fetchFromGitHub {
    owner = "4jamesccraven";
    repo = "mkdev";
    rev = "3ded78ac990e633da1fb14b7785cb68db3b5591e";
    sha256 = "1l688m439r5q6nigwc35nsypl96in7bfvgcainzjw4zgc2di784i";
  };

  buildInputs = [ python ];

  propagatedBuildInputs = [
    platformdirs
    pyyaml
    textual
  ];

  makeWrapperArgs = [
    "--set PYTHONPATH $src/src/mkdev"
  ];
}
