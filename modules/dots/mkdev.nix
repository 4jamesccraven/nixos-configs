{ pkgs, inputs, ... }:

{
  home-manager.users.jamescraven = {
    imports = [
      inputs.mkdev.homeManagerModule
    ];

    programs.mkdev = {
      enable = true;

      extraPackages = with inputs.mkdev.packages.${pkgs.system}; [
        mkf
      ];

      config = {
        recipe_dir = "/home/jamescraven/.config/mkdev/recipes";

        subs = {
          day = "date +%d";
          dir = "mk::dir";
          name = "mk::name";
          month = "date +%m";
          user = "whoami";
          year = "date +%Y";
        };
      };

      recipes = [
        {
          name = "basic-flake";
          description = "A simple flake with a devShell";
          languages = [
            "[38;2;126;126;255mNix[0m"
          ];
          contents = [
            {
              name = "flake.nix";
              content = ''
                {
                  description = "";

                  inputs = {
                    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
                    flake-utils.url = "github:numtide/flake-utils";
                  };

                  outputs = { flake-utils, nixpkgs, ... }: 
                    flake-utils.lib.eachDefaultSystem (system:
                      let
                        pkgs = import nixpkgs { inherit system; };
                      in {
                        devShells.default = pkgs.mkShell {
                          buildInputs = with pkgs; [

                          ];
                        };
                      });
                }

              '';
            }
          ];
        }
        {
          name = "rust-flake";
          description = "Nix flake that contains rust dependencies";
          languages = [
            "[38;2;126;126;255mNix[0m"
          ];
          contents = [
            {
              name = "flake.nix";
              content = ''
                {
                  description = "";

                  inputs = {
                    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
                    flake-utils.url = "github:numtide/flake-utils";
                  };

                  outputs =
                    { flake-utils, nixpkgs, ... }:
                    flake-utils.lib.eachDefaultSystem (
                      system:
                      let
                        pkgs = import nixpkgs { inherit system; };
                      in
                      {
                        devShells.default = pkgs.mkShell {
                          buildInputs = with pkgs; [
                            cargo
                            rustc
                            libgcc
                          ];

                          RUST_SRC_PATH = "$${pkgs.rustPlatform.rustLibSrc}";
                        };
                      }
                    );
                }

              '';
            }
          ];
        }
      ];
    };
  };
}
