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

      "vlc"
    ];

    masApps = {
      "The Unarchiver" = 425424353;
    };
  };
}
