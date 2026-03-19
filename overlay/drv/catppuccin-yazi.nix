{
  pkgs ? import <nixpkgs> { },
  lib ? pkgs.lib,
  variants ? [ "frappe" ],
  accents ? [ "blue" ],
  ...
}:

let
  validVariants = [
    "frappe"
    "latte"
    "macchiato"
    "mocha"
  ];

  validAccents = [
    "blue"
    "flamingo"
    "green"
    "lavender"
    "maroon"
    "mauve"
    "peach"
    "pink"
    "red"
    "rosewater"
    "sapphire"
    "sky"
    "teal"
    "yellow"
  ];

  pname = "catppuccin-yazi";
in
lib.checkListOfEnum "${pname}: variants" validVariants variants lib.checkListOfEnum
  "${pname}: accents"
  validAccents
  accents

  pkgs.stdenvNoCC.mkDerivation
  {
    inherit pname;
    version = "2025-12-29";

    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "yazi";
      rev = "fc69d6472d29b823c4980d23186c9c120a0ad32c";
      hash = "sha256-Og33IGS9pTim6LEH33CO102wpGnPomiperFbqfgrJjw=";
    };

    postInstall = ''
      mkdir $out
      ${lib.toShellVar "flavours" variants}
      ${lib.toShellVar "accents" accents}

      for flavour in "''${flavours[@]}"; do
          for accent in "''${accents[@]}"; do
              cp "$src/themes/$flavour/catppuccin-$flavour-$accent.toml" $out
          done
      done
    '';
  }
