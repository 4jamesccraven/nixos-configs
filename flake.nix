{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager?ref=master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, ... } @ inputs : {
      nixosConfigurations = {
        RioTinto = nixpkgs.lib.nixosSystem {
          specialArgts = {inherit inputs; };
          modules = [
            ./hosts/RioTinto.nix
          ];
        };

      };
  };
}
