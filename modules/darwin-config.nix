{
  pkgs,
  user,
  ...
}:
# let
#   customPkgs = let
#     mkPkg = name: pkgs.callPackage ../pkgs/app/${name}/package.nix {};
#   in {
#     discord = mkPkg "discord";
#     keyboardcleantool = mkPkg "keyboardcleantool";
#     macs-fan-control = mkPkg "macs-fan-control";
#     figma = mkPkg "figma";
#     proxyman = mkPkg "proxyman";
#     clop = mkPkg "clop";
#     imageoptim = mkPkg "imageoptim";
#     obs = mkPkg "obs";
#     ungoogled-chromium = mkPkg "ungoogled-chromium";
#     gifox = mkPkg "gifox";
#     burpsuite = mkPkg "burpsuite";
#     vlc = mkPkg "vlc";
#     tableplus = mkPkg "tableplus";
#   };
# in
{
  #   environment.systemPackages = with pkgs;
  #     [
  #       ghostty-bin
  #       brave # move to brew cuz it not trust brave from nix
  #       notion-app
  #       jetbrains.idea-community-bin
  #       slack
  #       zoom-us
  #       raycast
  #       appcleaner
  #       rectangle
  #       teams
  #       mongodb-compass
  #       modrinth-app
  #       google-chrome
  #       vscode
  #       postman
  #       openvpn
  #       the-unarchiver
  #       _1password-gui
  #     ]
  #     ++ builtins.attrValues customPkgs;

  system = {
    primaryUser = "${user}";
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
          {app = "/Applications/Brave Browser.app";}
          {app = "/System/Applications/Mail.app";}
          {app = "${pkgs.zed-editor}/Applications/Zed.app";}
          {app = "/Applications/Ghostty.app";}
          {app = "/Applications/Discord.app";}
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
        KeyRepeat = 2;
        InitialKeyRepeat = 15;
        WebKitDeveloperExtras = true;
      };
      "com.apple.Safari" = {
        AutoOpenSafeDownloads = false;
      };
      "com.apple.symbolichotkeys" = {
        AppleSymbolicHotKeys = {
          "118" = {
            enabled = false;
            value = {
              parameters = [
                65535
                18
                262144
              ];
              type = "standard";
            };
          };
          "119" = {
            enabled = false;
            value = {
              parameters = [
                65535
                19
                262144
              ];
              type = "standard";
            };
          };
          "120" = {
            enabled = false;
            value = {
              parameters = [
                65535
                20
                262144
              ];
              type = "standard";
            };
          };
          "176" = {
            enabled = false;
            value = {
              type = "SAE1.0";
            };
          };
          "64" = {
            enabled = false;
          };
          "65" = {
            enabled = false;
          };
          "79" = {
            enabled = true;
            value = {
              parameters = [
                65535
                123
                8650752
              ];
              type = "standard";
            };
          };
          "80" = {
            enabled = true;
            value = {
              parameters = [
                65535
                123
                8781824
              ];
              type = "standard";
            };
          };
          "81" = {
            enabled = true;
            value = {
              parameters = [
                65535
                124
                8650752
              ];
              type = "standard";
            };
          };
          "82" = {
            enabled = true;
            value = {
              parameters = [
                65535
                124
                8781824
              ];
              type = "standard";
            };
          };
        };
      };
    };

    activationScripts.postActivation.text = ''
      # Following line should allow us to avoid a logout/login cycle when changing settings
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';
  };

  nixpkgs.hostPlatform = "aarch64-darwin";

  nix.settings = {
    experimental-features = "nix-command flakes";
    trusted-users = ["root" "${user}"];
  };

  security.pam.services.sudo_local.touchIdAuth = true;
}
