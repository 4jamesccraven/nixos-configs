{
  description = "";

  inputs.nixpkgs.url = "https://nixos.org/channels/nixpkgs-unstable/nixexprs.tar.xz";

  outputs =
    { nixpkgs, ... }:
    let
      lib = nixpkgs.lib;
      eachDefaultSystem =
        function:
        lib.genAttrs [
          "x86_64-linux"
          "aarch64-linux"
          "x86_64-darwin"
          "aarch64-darwin"
        ] (system: function nixpkgs.legacyPackages.${system});
    in
    {
      devShells = eachDefaultSystem (pkgs: {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            cargo
            libgcc
            rustc
          ];

          RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
        };
      });

      packages = eachDefaultSystem (pkgs: {
        default =
          with pkgs;
          let
            manifest = (lib.importTOML ./Cargo.toml).package;
          in
          rustPlatform.buildRustPackage {
            pname = manifest.name;
            version = manifest.version;

            src = ./.;

            cargoLock.lockFile = ./Cargo.lock;
          };
      });
    };
}
