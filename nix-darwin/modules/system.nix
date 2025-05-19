{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # shell
    neovim
    fzf
    zsh
    zsh-powerlevel10k
    zsh-fzf-history-search
    zsh-history-substring-search
    nixd
    htop
    bat
    ripgrep
    eza

    zulu
    ngrok

    # app
    discord
    slack
    raycast
    zed-editor
    appcleaner
    rectangle
    mongodb-compass
    # obs-studio
    drawio
    tableplus
    modrinth-app

    # git
    pre-commit
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
        folder = "~/Pictures/Screenshots";
      }
    ];
  };

  # to view custom `defaults read something`
  # for an example `defaults read com.apple.finder`
  system.defaults.CustomUserPreferences = {
    NSGlobalDomain = {
      WebKitDeveloperExtras = true;
    };
    "com.apple.Safari" = {
      AutoOpenSafeDownloads = false;
    };
    "com.apple.screencapture" = {
      location = "~/Pictures/Screenshots";
      type = "png";
    };
  };

  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.hostPlatform = "aarch64-darwin";
  security.pam.services.sudo_local.touchIdAuth = true;
}
