{
  pkgs,
  home-manager,
  ...
}:
home-manager.lib.homeManagerConfiguration {
  pkgs = pkgs;
  modules = [
    (import ./modules/home.nix {
      pkgs = pkgs;
      lib = pkgs.lib;
      isDarwin = false;
    })
  ];
}
