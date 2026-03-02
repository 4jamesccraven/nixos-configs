{
  description = "ἐρωτηθεὶς τί ἐστι φίλος, ἔφη, μία ψυχὴ δύο σώμασιν ἐνοικοῦσα";

  inputs = {
    # :> nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable"; # TODO: replace with channel tarball
    waybar.url = "github:nixos/nixpkgs/ae67888ff7ef9dff69b3cf0cc0fbfbcd3a722abe";

    # :> nix-community
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager?ref=master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # :> me
    mkdev = {
      url = "github:4jamesccraven/mkdev";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    jcc-neovim = {
      url = "github:4jamesccraven/neovim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib;
      libjcc = import ./lib { inherit lib; };
      inherit (libjcc) mapFiles shellsFromDir templatesFromDir;

      myHosts = mapFiles (lib.removeSuffix ".nix") ./hosts;

      /*
        eachDefaultSystem :: (AttrSet (nixpkgs) -> a) -> AttrSet

        see https://ayats.org/blog/no-flake-utils.
      */
      eachDefaultSystem =
        function:
        lib.genAttrs [
          "aarch64-darwin"
          "aarch64-linux"
          "x86_64-darwin"
          "x86_64-linux"
        ] (system: function nixpkgs.legacyPackages.${system});

      /*
        mkHost :: string -> AttrSet (NixOS System)

        Generates a NixOS system from a name, which is inferred to be the name
        of the host file in ./hosts/
      */
      mkHost =
        name:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs libjcc;
          };
          modules = [
            ./hosts/${name}.nix
            ./overlay
          ];
        };
    in
    {

      nixosConfigurations = lib.genAttrs myHosts mkHost;

      devShells = eachDefaultSystem (pkgs: shellsFromDir pkgs ./shells);

      templates = templatesFromDir ./templates;

    };
}
