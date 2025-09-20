{
  pkgs,
  home-manager,
  ...
}: user:
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  modules = [
    (import ./modules/home.nix {
      inherit pkgs user;
      lib = pkgs.lib;
      isDarwin = false;
    })
  ];
}
