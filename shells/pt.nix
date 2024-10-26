{ pkgs, ... }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    python310
    cargo
    libgcc
    rustc
  ];

  RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
}
