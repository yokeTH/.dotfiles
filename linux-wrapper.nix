{
  pkgs,
  home-manager,
  inputs,
  ...
}: user:
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  modules = [
    (import ./modules/home.nix {
      inherit pkgs user inputs;
      lib = pkgs.lib;
      isDarwin = false;
    })
  ];
}
