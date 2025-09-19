{
  description = "A flake system configure";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-darwin,
    nix-homebrew,
    home-manager,
    ...
  }: let
    system = "aarch64-darwin";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      config.allowUnsupportedSystem = true;
    };

    mkDarwin = import ./aarch64-darwin.nix {
      inherit nix-darwin nix-homebrew home-manager pkgs;
    };
  in {
    darwinConfigurations."Thanapons-MacBook-Pro" = mkDarwin;

    homeConfigurations."yoketh" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [./modules/home.nix];
    };
  };
}
