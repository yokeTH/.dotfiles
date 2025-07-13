{
  description = "nix-darwin system flake";
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
    nix-darwin,
    nixpkgs,
    nix-homebrew,
    home-manager,
    # nix-index-database,
    ...
  }: let
    # We'll use this platform for darwin on Apple Silicon
    system = "aarch64-darwin";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      config.allowUnsupportedSystem = true;
    };
    fontModule = import ./modules/fonts.nix {inherit pkgs;};
    # Import the modules
    systemModule = import ./modules/system.nix {inherit pkgs;};
    homebrewModule = {
      config,
      lib,
      ...
    }:
      import ./modules/homebrew.nix {
        inherit config lib;
        inputs = inputs;
      };
  in {
    darwinConfigurations."Thanapons-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [
        systemModule
        nix-homebrew.darwinModules.nix-homebrew
        homebrewModule
        fontModule
        home-manager.darwinModules.home-manager
        {
          home-manager.backupFileExtension = "backup";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.yoketh = import ./home.nix;
          users.users.yoketh = {
            name = "yoketh";
            home = "/Users/yoketh";
          };
        }
        # nix-index-database.darwinModules.nix-index
        # {
        #   programs.nix-index-database.comma.enable = true;
        # }
      ];
    };
  };
}
