{
  description = "ἐρωτηθεὶς τί ἐστι φίλος, ἔφη, μία ψυχὴ δύο σώμασιν ἐνοικοῦσα";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Helpers
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager?ref=master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";

    # Personal Flakes
    mkdev = {
      url = "github:4jamesccraven/mkdev";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wf-bot.url = "github:4jamesccraven/warframe-bot";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }@inp:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      lib = pkgs.lib;
      utils = import ./util {
        pkgs = pkgs;
        lib = lib;
      };
      inputs = inp // {
        utils = utils;
      };
    in
    flake-utils.lib.eachDefaultSystemPassThrough (system: {
      nixosConfigurations = {
        RioTinto = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./hosts/RioTinto.nix
          ];
        };

        vaal = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./hosts/vaal.nix
          ];
        };

        tokoro = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./hosts/tokoro.nix
          ];
        };

        wsl = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./hosts/wsl.nix
          ];
        };
      };
    })
    // flake-utils.lib.eachDefaultSystem (system: {

      devShells = utils.shellsFromDir ./shells;

      packages.exportNeovim =
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        pkgs.callPackage ./util/neovim {
          pkgs = pkgs;
          self = self;
        };
    });
}
