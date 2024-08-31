{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager?ref=master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # devShell stuff
    python310-14.url = "github:nixos/nixpkgs/0cb2fd7c59fed0cd82ef858cbcbdb552b9a33465";
  };

  outputs = { nixpkgs, ... } @ inputs : {
    nixosConfigurations = {
      RioTinto = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs; };
        modules = [
          ./hosts/RioTinto.nix
        ];
      };

      vaal = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs; };
        modules = [
          ./hosts/vaal.nix
        ];
      };

      tokoro = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs; };
        modules = [
          ./hosts/tokoro.nix
        ];
      };
    };

    devShells.x86_64-linux =
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      dependencies = {
        python310 = [ inputs.python310-14.legacyPackages.x86_64-linux.python310 ];
        rust = with pkgs; [ cargo libgcc rustc ];
      };
    in {

      rust = pkgs.mkShell {
        buildInputs = dependencies.rust;

        shellHook = ''
          clear
        '';
      };

      pct = pkgs.mkShell {
        buildInputs = with dependencies; rust ++ python310;

        shellHook = ''
          clear
        '';
      };

    };
  };
}
