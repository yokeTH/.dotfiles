{
  nix-darwin,
  pkgs,
  nix-homebrew,
  home-manager,
  inputs,
  ...
}: user: let
  system = "aarch64-darwin";
  fontModule = import ./modules/font.nix {inherit pkgs;};
  systemModule = import ./modules/darwin-config.nix {inherit pkgs user;};
  homebrewModule = import ./modules/homebrew.nix {inherit user;};
in
  nix-darwin.lib.darwinSystem {
    modules = [
      systemModule
      nix-homebrew.darwinModules.nix-homebrew
      homebrewModule
      fontModule
      home-manager.darwinModules.home-manager
      {
        nixpkgs.hostPlatform = system;
        nixpkgs.config.allowUnfree = true;

        system.stateVersion = 6;

        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
        home-manager.users."${user}" = {
          config,
          pkgs,
          lib,
          ...
        }:
          import ./modules/home.nix {
            inherit config pkgs lib user inputs;
            isDarwin = true;
          };

        users.users."${user}" = {
          name = "${user}";
          home = "/Users/${user}";
        };
      }
    ];
  }
