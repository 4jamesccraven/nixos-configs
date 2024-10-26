{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager?ref=master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { nixpkgs, ... }@inputs:
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
      };

      devShells.x86_64-linux =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          lib = pkgs.lib;
          shells = builtins.listToAttrs (
            map (name: {
              name = lib.removeSuffix ".nix" name;
              value = import ./shells/${name} { inherit pkgs; };
            }) (builtins.attrNames (builtins.readDir ./shells))
          );
        in
        shells;
    };
}
