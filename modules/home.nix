{
  config,
  pkgs,
  lib,
  isDarwin,
  user,
  ...
}: let
  gcloud = pkgs.google-cloud-sdk.withExtraComponents [pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin];
  deploys-app = pkgs.callPackage ../pkgs/cli/deploys-app/package.nix {};
  portless = pkgs.callPackage ../pkgs/cli/portless/package.nix {};

  githubGitignore = filename: let
    gitignore = pkgs.fetchFromGitHub {
      owner = "github";
      repo = "gitignore";
      rev = "4488915eec0b3a45b5c63ead28f286819c0917de";
      hash = "sha256-t/+ZQiGEziCqs8kIdlb/3/KBs0XQnHyQC+xoV2rzfbQ=";
    };
  in
    lib.splitString "\n" (builtins.readFile "${gitignore}/${filename}");

  braveExtensions = [
    "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
    "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1Password
    "hlepfoohegkhhmjieoechaddaejaokhf" # Refined GitHub
    "lnjaiaapbakfhlbjenjkhffcdpoompki" # Catppuccin for Web File Explorer Icons
    "eifflpmocdbdmepbjaopkkhbfmdgijcc" # JSON Viewer Pro
    "djflhoibgkdhkhhcedjiklpkjnoahfmg" # User-Agent Switcher
  ];

  toExtensionFile = id: {
    name = "Library/Application Support/BraveSoftware/Brave-Browser/External Extensions/${id}.json";
    value = {
      text = builtins.toJSON {
        external_update_url = "https://clients2.google.com/service/update2/crx";
      };
    };
  };
in {
  imports =
    [
      ./1password.nix
    ]
    ++ lib.optionals isDarwin [
      ./zed.nix
      ./ghostty.nix
    ];

  nix.package = lib.mkIf (!isDarwin) pkgs.nix;
  nix.settings.experimental-features = lib.mkIf (!isDarwin) ["nix-command" "flakes"];

  programs.home-manager.enable = true;
  home.stateVersion = "26.05";
  home.username = lib.mkIf (!isDarwin) "${user}";
  home.homeDirectory = lib.mkIf (!isDarwin) "/home/${user}";

  home.packages = with pkgs; [
    nil
    nixd

    neovim
    fzf
    zsh
    zsh-powerlevel10k
    zsh-fzf-history-search
    htop
    bat
    ripgrep
    eza

    tmux

    zulu
    # ngrok

    # uxplay

    git
    gh
    pre-commit
    graphviz
    gcloud
    tree

    ffmpeg
    # _1password-cli
    deploys-app
    portless

    cloudflared
    # bitwarden-cli
    gnupg
    jujutsu
    claude-code
  ];

  programs.git = {
    enable = true;
    ignores =
      githubGitignore "Global/macOS.gitignore"
      ++ githubGitignore "Global/Linux.gitignore"
      ++ githubGitignore "Global/Vim.gitignore"
      ++ githubGitignore "Global/VisualStudioCode.gitignore"
      ++ githubGitignore "Global/GPG.gitignore"
      ++ [".direnv" ".envrc" ".zed"];
    settings =
      {
        user = {
          name = "Thanapon Johdee";
          email = "66236295+yokeTH@users.noreply.github.com";
        };

        gpg = {
          format = "ssh";
        };
        "gpg \"ssh\"" = {
          allowedSignersFile = "~/.config/git/allowed_signers";
        };

        commit = {
          gpgsign = true;
        };

        user = {
          signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOlhqMGCbubg6mYk5OlB5DKIVXDqIBdDfI6fcMChRwD/";
        };

        init = {
          defaultBranch = "main";
        };

        aliases = {
          cleanup = "!git branch --merged | grep  -v '\\*\\|master\\|develop' | xargs -n 1 -r git branch -d";
          prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
          root = "rev-parse --show-toplevel";
        };
      }
      // (
        if isDarwin
        then {
          "url \"ssh://git@github.com/\"" = {
            insteadOf = "https://github.com/";
          };
        }
        else {}
      );
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.nix-direnv.enable = true;

  programs.fastfetch.enable = true;

  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    enableCompletion = true;
    autosuggestion.enable = true;
    autosuggestion.highlight = "fg=cyan";
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    history.size = 10000;

    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
    };
    initContent = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
    '';
    shellAliases =
      {
        ll = "ls -l";
        ".." = "cd ..";
        c = "clear";
        g = "git";
        py3 = "python3";
        top = "htop";
        cat = "bat -p --paging=never";
        grep = "rg";
        ls = "eza";
        md = "mkdir";

        ga = "git add";
        gc = "git commit";
        gco = "git checkout";
        gcp = "git cherry-pick";
        gdiff = "git diff";
        gl = "git prettylog";
        gp = "git push";
        gs = "git status";
        gt = "git tag";
      }
      // (
        if (!isDarwin)
        then {
          pbcopy = "xclip";
          pbpaste = "xclip -o";
        }
        else {}
      );

    shellGlobalAliases = {
      UUID = "$(uuidgen | tr -d \\n)";
      G = "| rg";
    };
  };

  programs.jujutsu = {
    enable = true;
    package = pkgs.jujutsu;
    settings = {
      user = {
        name = "Thanapon Johdee";
        email = "66236295+yokeTH@users.noreply.github.com";
      };

      ui.show-cryptographic-signatures = true;
      ui.default-command = "log";

      signing = {
        backend = "ssh";
        behavior = "own";
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOlhqMGCbubg6mYk5OlB5DKIVXDqIBdDfI6fcMChRwD/";
        backends.ssh = {
          allowed-signers = "${config.xdg.configHome}/jj/allowed_signers";
        };
      };

      aliases = {
        b = ["branch"];
        d = ["desc"];
        f = ["git" "fetch"];
        n = ["new"];
        p = ["git" "push"];
        s = ["st"];

        # Move the closest bookmark to the current commit. This is useful when
        # working on a named branch, creating a bunch of commits, and then
        # needing to update the bookmark before pushing.
        tug = ["bookmark" "move" "--from" "closest_bookmark(@-)" "--to" "@-"];

        # Rebase the current branch onto the trunk.
        retrunk = ["rebase" "-d" "trunk()"];
      };

      revset-aliases = {
        "closest_bookmark(to)" = "heads(::to & bookmarks())";
        "fork_history(to, from)" = "fork_point(to | from)..@";
      };

      template-aliases = {
        "format_timestamp(timestamp)" = "timestamp.ago()";
      };
    };
  };

  home.file =
    {
      ".p10k.zsh".source = ../dotfiles/p10k.zsh;
      ".config/git/allowed_signers".text = ''
        66236295+yokeTH@users.noreply.github.com namespaces="git" ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOlhqMGCbubg6mYk5OlB5DKIVXDqIBdDfI6fcMChRwD/
      '';
    }
    // lib.optionalAttrs isDarwin (
      builtins.listToAttrs (map toExtensionFile braveExtensions)
    );

  home.sessionVariables = {
    EDITOR =
      if isDarwin
      then "zed --wait"
      else "vim";
    TERM = "xterm-256color";
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    SSH_AUTH_SOCK = "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
  };

  xdg.enable = true;
  xdg.configFile."jj/allowed_signers".text = ''
    66236295+yokeTH@users.noreply.github.com namespaces="git" ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOlhqMGCbubg6mYk5OlB5DKIVXDqIBdDfI6fcMChRwD/
  '';

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    pinentry.package = pkgs.pinentry_mac;
  };

  home.activation.configureBrave = lib.hm.dag.entryAfter ["writeBoundary"] ''
    SOURCE_PREFS="${pkgs.writeText "brave-golden-prefs.json" (builtins.readFile ../dotfiles/brave.json)}"

    BRAVE_DIR="$HOME/Library/Application Support/BraveSoftware/Brave-Browser"

    for PROFILE_DIR in "$BRAVE_DIR"/Default "$BRAVE_DIR"/Profile*; do
      TARGET_PREFS="$PROFILE_DIR/Preferences"

      if [ -f "$TARGET_PREFS" ]; then
        echo "Config into: $PROFILE_DIR"
        ${pkgs.jq}/bin/jq --slurpfile src "$SOURCE_PREFS" '. * $src[0]' "$TARGET_PREFS" > "$TARGET_PREFS.tmp" && mv "$TARGET_PREFS.tmp" "$TARGET_PREFS"
      fi
    done
  '';
}
