{
  pkgs,
  home-manager,
  ...
}: let
  system = "aarch64-darwin";
  lib = pkgs.lib;
  stdenv = pkgs.stdenv;
in
  home-manager.lib.homeManagerConfiguration {
    pkgs = pkgs;
    modules = [
      (import ./modules/home.nix {
        pkgs = pkgs;
        lib = lib;
        isDarwin = false;
      })
    ];
  }
