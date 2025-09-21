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
    nixpkgs,
    nix-darwin,
    nix-homebrew,
    home-manager,
    ...
  } @ inputs: let
    darwinSystem = "aarch64-darwin";
    linuxSystem = "aarch64-linux";

    darwinPkgs = import nixpkgs {
      system = darwinSystem;
      config.allowUnfree = true;
    };

    linuxPkgs = import nixpkgs {
      system = linuxSystem;
      config.allowUnfree = true;
    };

    mkDarwin = import ./darwin-wrapper.nix {
      inherit nix-darwin nix-homebrew home-manager darwinPkgs inputs;
      pkgs = darwinPkgs;
    };

    mkLinux = import ./linux-wrapper.nix {
      inherit home-manager inputs;
      pkgs = linuxPkgs;
    };
  in {
    darwinConfigurations."Thanapons-MacBook-Pro" = mkDarwin "yoketh";

    homeConfigurations."yoketh" = mkLinux "yoketh";

    homeConfigurations."ubuntu" = mkLinux "ubuntu";
  };
}
