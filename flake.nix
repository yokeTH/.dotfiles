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

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    nix-homebrew,
    home-manager,
    ...
  }: let
    darwinSystem = "aarch64-darwin";
    linuxSystem = "aarch64-linux";

    darwinPkgs = import nixpkgs {
      system = darwinSystem;
      config.allowUnfree = true;
      config.allowUnsupportedSystem = true;
    };

    linuxPkgs = import nixpkgs {
      system = linuxSystem;
      config.allowUnfree = true;
      config.allowUnsupportedSystem = true;
    };

    mkDarwin = import ./aarch64-darwin.nix {
      inherit nix-darwin nix-homebrew home-manager darwinPkgs;
      pkgs = darwinPkgs;
    };
  in {
    darwinConfigurations."Thanapons-MacBook-Pro" = mkDarwin;

    homeConfigurations."yoketh" = home-manager.lib.homeManagerConfiguration {
      pkgs = linuxPkgs;
      modules = [./modules/home-linux.nix];
    };
  };
}
