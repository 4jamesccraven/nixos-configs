{
  pkgs ? import <nixpkgs> { },
  ...
}:

pkgs.treefmt.withConfig {
  runtimeInputs = with pkgs; [
    # keep-sorted start
    deadnix
    keep-sorted
    nixfmt
    # keep-sorted end
  ];

  settings = {
    tree-root-file = "README.md";

    formatter = {
      # keep-sorted start block=yes newline_separated=yes
      deadnix = {
        command = "deadnix";
        options = [ "--edit" ];
        includes = [ "*.nix" ];
      };

      keep-sorted = {
        command = "keep-sorted";
        includes = [ "*" ];
      };

      nixfmt = {
        command = "nixfmt";
        includes = [ "*" ];
      };
      # keep-sorted end
    };
  };
}
