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

    casks = [
      "playcover-community"
      "orbstack"
      "gifox"

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
