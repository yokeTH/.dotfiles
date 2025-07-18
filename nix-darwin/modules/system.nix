{pkgs, ...}: let
  gcloud = pkgs.google-cloud-sdk.withExtraComponents [pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin];
in {
  environment.systemPackages = with pkgs; [
    # shell
    alejandra
    nixd
    nil
    devenv

    neovim
    fzf
    zsh
    zsh-powerlevel10k
    zsh-fzf-history-search
    htop
    bat
    ripgrep
    eza
    gnupg

    zulu
    ngrok

    uxplay

    # app
    # discord
    # slack
    # raycast
    # zed-editor
    # appcleaner
    # rectangle
    # mongodb-compass
    # obs-studio
    # drawio
    # tableplus
    # modrinth-app

    git
    pre-commit
    graphviz
    gcloud
  ];

  system.primaryUser = "yoketh";

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
        app = "/Applications/Zed.app";
      }
      {
        app = "/Applications/Ghostty.app";
      }
      {
        spacer = {small = true;};
      }
      {
        folder = "/Users/yoketh/Pictures/Screenshots";
      }
      {
        folder = "/Users/yoketh/Repo";
      }
      {
        spacer = {small = true;};
      }
    ];

    finder.FXPreferredViewStyle = "Nlsv";
    finder.ShowPathbar = false;
    finder.ShowStatusBar = true;

    screencapture.disable-shadow = true;
    screencapture.include-date = true;
    screencapture.location = "~/Pictures/Screenshots";
    screencapture.type = "png";
    screencapture.show-thumbnail = false;
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
  };

  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.trusted-users = ["root" "yoketh"];
  # nix.settings.extra-substituters = "https://devenv.cachix.org";
  # nix.settings.extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";

  nixpkgs.hostPlatform = "aarch64-darwin";
  security.pam.services.sudo_local.touchIdAuth = true;
}
