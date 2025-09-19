{...}: {
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "yoketh";
  };

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "uninstall";
      upgrade = true;
      autoUpdate = true;
    };

    taps = [
      "hashicorp/tap"
    ];

    brews = [
      "hashicorp/tap/terraform"
    ];

    casks = [
      "playcover-community"
      "figma"
      "microsoft-teams"
      "zoom"
      "slack"
      "raycast"
      "appcleaner"
      "rectangle"
      "mongodb-compass"
      "drawio"
      "tableplus"
      "modrinth"
      "orbstack"
      "proxyman"
      "gifox"
      "google-chrome"
      "imageoptim"
      "obs"
      "visual-studio-code"
      "postman"
      "openvpn-connect"
      "ungoogled-chromium"
      "burp-suite"
      "vlc"
    ];

    masApps = {
      "The Unarchiver" = 425424353;
    };
  };
}
