{pkgs, ...}: let
  gcloud = pkgs.google-cloud-sdk.withExtraComponents [pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin];
  discord = pkgs.callPackage ../lib/discord.nix {};
  # git-fork = pkgs.callPackage ../lib/git-fork.nix {};
  keyboardcleantool = pkgs.callPackage ../lib/keyboardcleantool.nix {};
  macs-fan-control = pkgs.callPackage ../lib/macs-fan-control.nix {};
  figma = pkgs.callPackage ../lib/figma.nix {};
  proxyman = pkgs.callPackage ../lib/proxyman.nix {};
  clop = pkgs.callPackage ../lib/clop.nix {};
in {
  environment.systemPackages = with pkgs;
    [
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

      git
      gh
      pre-commit
      graphviz
      gcloud
      tree

      ffmpeg

      ghostty-bin
      brave
      notion-app
      jetbrains.idea-community-bin
      slack
      zoom-us
      raycast
      appcleaner
      rectangle
      teams
      mongodb-compass
      tableplus
      modrinth-app
      # proxyman
      google-chrome
    ]
    ++ [
      discord
      keyboardcleantool
      macs-fan-control
      figma
      # git-fork
      proxyman
      clop
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
        app = "${pkgs.brave}/Applications/Brave Browser.app";
      }
      {
        app = "/System/Applications/Mail.app";
      }
      {
        app = "${pkgs.zed-editor}/Applications/Zed.app";
      }
      {
        app = "${pkgs.ghostty-bin}/Applications/Ghostty.app";
      }
      {
        app = "${discord}/Applications/Discord.app";
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
