{ lib, python312Packages }:

with python312Packages;
buildPythonApplication {
  pname = "mkdev";
  version = "2.0";
  src = pkgs.fetchFromGitHub {
    owner = "4jamesccraven";
    repo = "mkdev";
    rev = "b1f6ad5727e5c8cac6250d2d8c7b846a925e0d61";
    sha256 = "0852acdcmxj7i1rzyak15a0bycq5pn5w7f76ns16w7ginwvqh5lj";
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

  postInstall = ''
    cp -r $src/src/mkdev/config $out/lib/python3.12/site-packages/mkdev/config
    cp -r $src/src/mkdev/help.txt $out/lib/python3.12/site-packages/mkdev/help.txt
  '';
}
