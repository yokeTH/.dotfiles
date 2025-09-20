{pkgs, ...}: let
  customPkgs = let
    mkPkg = name: pkgs.callPackage ../pkgs/app/${name}/package.nix {};
  in {
    discord = mkPkg "discord";
    keyboardcleantool = mkPkg "keyboardcleantool";
    macs-fan-control = mkPkg "macs-fan-control";
    figma = mkPkg "figma";
    proxyman = mkPkg "proxyman";
    clop = mkPkg "clop";
    imageoptim = mkPkg "imageoptim";
    obs = mkPkg "obs";
    ungoogled-chromium = mkPkg "ungoogled-chromium";
    gifox = mkPkg "gifox";
    burpsuite = mkPkg "burpsuite";
    vlc = mkPkg "vlc";
  };
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
      google-chrome
      vscode
      postman
      openvpn
      the-unarchiver
    ]
    ++ builtins.attrValues customPkgs;

  system = {
    primaryUser = "yoketh";
    stateVersion = 6;

    defaults = {
      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.5;
        expose-animation-duration = 0.5;
        largesize = 64;
        magnification = true;
        tilesize = 24;
        show-recents = false;
        persistent-apps = [
          {app = "${pkgs.brave}/Applications/Brave Browser.app";}
          {app = "/System/Applications/Mail.app";}
          {app = "${pkgs.zed-editor}/Applications/Zed.app";}
          {app = "${pkgs.ghostty-bin}/Applications/Ghostty.app";}
          {app = "${customPkgs.discord}/Applications/Discord.app";}
          {spacer = {small = true;};}
        ];
      };

      finder = {
        FXPreferredViewStyle = "Nlsv";
        ShowPathbar = false;
        ShowStatusBar = true;
      };

      screencapture = {
        disable-shadow = true;
        include-date = true;
        location = "~/Pictures/Screenshots";
        type = "png";
        show-thumbnail = false;
      };
    };

    defaults.CustomUserPreferences = {
      NSGlobalDomain = {
        WebKitDeveloperExtras = true;
      };
      "com.apple.Safari" = {
        AutoOpenSafeDownloads = false;
      };
    };
  };

  nix.settings = {
    experimental-features = "nix-command flakes";
    trusted-users = ["root" "yoketh"];
    # extra-substituters = "https://devenv.cachix.org";
    # extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
  };

  nixpkgs.hostPlatform = "aarch64-darwin";

  security.pam.services.sudo_local.touchIdAuth = true;
}
