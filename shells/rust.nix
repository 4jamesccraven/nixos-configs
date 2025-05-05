{ pkgs, ... }:

{
  buildInputs = with pkgs; [
    cargo
    libgcc
    rustc
  ];

  RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
}
