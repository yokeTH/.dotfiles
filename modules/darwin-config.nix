{pkgs, ...}: let
  discord = pkgs.callPackage ../pkgs/discord.nix {};
  # git-fork = pkgs.callPackage ../pkgs/git-fork.nix {};
  keyboardcleantool = pkgs.callPackage ../pkgs/keyboardcleantool.nix {};
  macs-fan-control = pkgs.callPackage ../pkgs/macs-fan-control.nix {};
  figma = pkgs.callPackage ../pkgs/figma.nix {};
  proxyman = pkgs.callPackage ../pkgs/proxyman.nix {};
  clop = pkgs.callPackage ../pkgs/clop.nix {};
  imageoptim = pkgs.callPackage ../pkgs/imageoptim.nix {};
  obs = pkgs.callPackage ../pkgs/obs.nix {};
  ungoogled-chromium = pkgs.callPackage ../pkgs/ungoogled-chromium.nix {};
  gifox = pkgs.callPackage ../pkgs/gifox.nix {};
  burpsuite = pkgs.callPackage ../pkgs/burpsuite.nix {};
  vlc = pkgs.callPackage ../pkgs/vlc.nix {};
in {
  environment.systemPackages = with pkgs;
    [
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
      vscode
      postman
      openvpn
      the-unarchiver
    ]
    ++ [
      discord
      keyboardcleantool
      macs-fan-control
      figma
      # git-fork
      proxyman
      clop
      imageoptim
      obs
      ungoogled-chromium
      gifox
      burpsuite
      vlc
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
