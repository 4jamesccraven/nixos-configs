{
  pkgs ? import <nixpkgs> { },
  lib ? pkgs.lib,
  variants ? [ "latte" ],
  ...
}:

let
  validVariants = [
    "frappe"
    "latte"
    "macchiato"
    "mocha"
  ];

  pname = "catppuccin-bat";
in
lib.checkListOfEnum "${pname}: variants" validVariants variants

  pkgs.stdenvNoCC.mkDerivation
  {
    inherit pname;
    version = "2025-06-29";

    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "bat";
      rev = "6810349b28055dce54076712fc05fc68da4b8ec0";
      hash = "sha256-lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
    };

    postInstall =
      let
        flavours = map lib.toSentenceCase variants;
      in
      /* bash */ ''
        mkdir $out
        ${lib.toShellVar "flavours" flavours}
        for flavour in "''${flavours[@]}"; do
            cp "$src/themes/Catppuccin $flavour.tmTheme" $out
        done
      '';
  }
