{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.neovim
    pkgs.raycast
    pkgs.zed-editor
    pkgs.fzf
    pkgs.zsh
    pkgs.zsh-powerlevel10k
    pkgs.zsh-fzf-history-search
    pkgs.zsh-history-substring-search
    pkgs.nixd
    pkgs.htop
    pkgs.bat
    pkgs.ripgrep
    pkgs.eza
  ];

  system.stateVersion = 6;

  system.defaults = {
    dock.autohide = true;
    dock.autohide-delay = 0.0;
    dock.autohide-time-modifier = 0.5;
    dock.expose-animation-duration = 0.5;
    dock.largesize = 64;
    dock.magnification = true;
    dock.tilesize = 24;
    dock.show-recents = false;
    dock.persistent-apps = [
      {
        app = "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app";
      }
      {
        app = "/System/Applications/Mail.app";
      }
      {
        app = "${pkgs.zed-editor}/Applications/Zed.app";
      }
      {
        app = "/Applications/Ghostty.app";
      }
      {
        spacer = { small = true; };
      }
      {
        folder = "/System/Applications/Utilities";
      }
    ];
  };

  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.hostPlatform = "aarch64-darwin";
}
