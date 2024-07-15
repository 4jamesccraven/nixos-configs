{ lib, python312Packages }:

with python312Packages;
buildPythonApplication {
  pname = "mkdev";
  version = "2.0.1";
  src = pkgs.fetchFromGitHub {
    owner = "4jamesccraven";
    repo = "mkdev";
    rev = "3253f017db1efa214d3b3d344d44b556d3c148fc";
    sha256 = "195cnbzbksdps4la3hlqs2jj97aggkm1rjdhg6cabq5p4ds2z761";
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
