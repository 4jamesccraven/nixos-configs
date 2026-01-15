{
  description = "ἐρωτηθεὶς τί ἐστι φίλος, ἔφη, μία ψυχὴ δύο σώμασιν ἐνοικοῦσα";

  inputs = {
    # nixpkgs versions
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-openrgb-09.url = "github:nixos/nixpkgs/22e95fb3a1a0e1533fd5e4e22002f843f79249db";

    # additional modules
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager?ref=master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 3rd party packages
    mkdev = {
      url = "github:4jamesccraven/mkdev";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      nixpkgs-openrgb-09,
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

      nixosConfigurations =
        let
          mkHost =
            name:
            nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs; };
              modules = [
                ./hosts/${name}.nix
                ./overlay
                {
                  nixpkgs.overlays = [
                    (final: prev: {
                      openrgb =
                        let
                          pkgs = import nixpkgs-openrgb-09 { system = system; };
                        in
                        pkgs.openrgb;
                    })
                  ];
                }
              ];
            };
          myHosts = builtins.filter (file: file != "common") (
            utils.mapFiles (lib.removeSuffix ".nix") ./hosts
          );
        in
        lib.genAttrs myHosts mkHost;

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
