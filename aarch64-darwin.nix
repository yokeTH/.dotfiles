{
  nix-darwin,
  pkgs,
  nix-homebrew,
  home-manager,
  ...
}: let
  system = "aarch64-darwin";
  fontModule = import ./modules/font.nix {inherit pkgs;};
  systemModule = import ./modules/darwin-config.nix {inherit pkgs;};
in
  nix-darwin.lib.darwinSystem {
    inherit system;

    specialArgs = {inherit pkgs;};

    modules = [
      systemModule
      nix-homebrew.darwinModules.nix-homebrew
      ./modules/homebrew.nix
      fontModule
      home-manager.darwinModules.home-manager
      {
        nixpkgs.hostPlatform = system;
        nixpkgs.config.allowUnfree = true;

        system.stateVersion = 6;

        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
        home-manager.users.yoketh = import ./modules/home.nix;

        users.users.yoketh = {
          name = "yoketh";
          home = "/Users/yoketh";
        };
      }
    ];
  }
