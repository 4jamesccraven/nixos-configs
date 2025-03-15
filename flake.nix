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
    wf-bot.url = "github:4jamesccraven/warframe-bot";
  };

  outputs =
    { nixpkgs, ... }@inputs:
    {
      nixosConfigurations = {
        RioTinto =
          let
            system = "x86_64-linux";
          in
          nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs system;
            };
            modules = [
              ./hosts/RioTinto.nix
            ];
          };

        vaal =
          let
            system = "x86_64-linux";
          in
          nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs system;
            };
            modules = [
              ./hosts/vaal.nix
            ];
          };

        tokoro =
          let
            system = "x86_64-linux";
          in
          nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs system;
            };
            modules = [
              ./hosts/tokoro.nix
            ];
          };

        wsl =
          let
            system = "x86_64-linux";
          in
          nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs system;
            };
            modules = [
              ./hosts/wsl.nix
            ];
          };
      };

      devShells.x86_64-linux =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          lib = pkgs.lib;

          shells = builtins.listToAttrs (
            map (
              name:
              let
                shell = (import ./shells/${name} { inherit pkgs; });
              in
              {
                name = lib.removeSuffix ".nix" name;
                value = shell;
              }
            ) (builtins.attrNames (builtins.readDir ./shells))
          );
        in
        shells;
    };
}
