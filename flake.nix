{
  description = "ἐρωτηθεὶς τί ἐστι φίλος, ἔφη, μία ψυχὴ δύο σώμασιν ἐνοικοῦσα";

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # nix-community
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager?ref=master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # me
    mkdev = {
      url = "github:4jamesccraven/mkdev";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
    jcc-neovim = {
      url = "github:4jamesccraven/neovim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }@inputs:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      lib = pkgs.lib;
      utils = import ./util { inherit pkgs lib; };
    in
    flake-utils.lib.eachDefaultSystemPassThrough (system: {

      nixosConfigurations =
        let
          mkHost =
            name:
            nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit inputs;
                jcc-utils = utils;
              };
              modules = [
                ./hosts/${name}.nix
                ./overlay
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
    });
}
