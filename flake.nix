{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager?ref=master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mkdev = {
      url = "github:4jamesccraven/mkdev";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nx.url = "github:4jamesccraven/nx";
    wf-bot.url = "github:4jamesccraven/warframe-bot";
  };

  outputs =
    { self, nixpkgs, ... }@inp:
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
    {
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

      devShells.x86_64-linux = utils.shellsFromDir ./shells;

      packages.x86_64-linux.exportNeovim =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        in
        pkgs.callPackage ./util/neovim {
          pkgs = pkgs;
          self = self;
        };
    };
}
