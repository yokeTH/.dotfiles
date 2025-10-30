{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;
    extensions = [
      "catppuccin"
      "docker-compose"
      "golangci-lint"
      "macos-classic"
      "prisma"
      "svelte"
      "xml"
      "catppuccin-icons"
      "dockerfile"
      "html"
      "make"
      "proto"
      "toml"
      "csv"
      "env"
      "java"
      "ruby"
      "verilog"
      "cucumber"
      "git-firefly"
      "ktrz-monokai"
      "php"
      "sql"
      "vue"
      "nix"
    ];
    extraPackages = [pkgs.nixd];
    userSettings = {
      vim_mode = true;
      relative_line_numbers = false;
      disable_ai = true;
      tabs = {
        close_position = "left";
        file_icons = true;
        git_status = true;
        activate_on_close = "history";
        show_close_button = "hover";
        show_diagnostics = "errors";
      };
      preferred_line_length = 120;
      soft_wrap = "bounded";
      theme = "Catppuccin Macchiato";
      icon_theme = "Catppuccin Macchiato";
      edit_predictions.disabled_globs = ["*"];
      ui_font_size = 16;
      ui_font_family = ".ZedSans";
      buffer_font_size = 14;
      terminal = {
        dock = "bottom";
        font_family = "JetBrainsMono Nerd Font";
        font_size = 14;
      };
      languages = {
        TOML = {
          language_servers = ["!air.toml"];
        };
        Nix = {
          formatter = {
            external = {
              command = "alejandra";
              arguments = ["--quiet" "--"];
            };
          };
        };
        SQL = {
          formatter = {
            external = {
              command = "sql-formatter";
            };
          };
        };
      };
      lsp = {
        vtsls = {
          settings = {
            typescript = {
              preferences = {
                importModuleSpecifier = "non-relative";
              };
            };
          };
        };
        rust-analyzer = {
          initialization_options = {
            inlayHints = {
              enable = true;
              showTypeHints = true;
              maxLength = null;
              lifetimeElisionHints = {
                enable = "skip_trivial";
                useParameterNames = true;
              };
              closureReturnTypeHints = {
                enable = "always";
              };
            };
          };
        };
      };
      inlay_hints.enabled = true;
    };
    userKeymaps = [
      # {
      #   context = "Workspace";
      #   bindings = {
      #     "shift shift" = "file_finder::Toggle";
      #   };
      # }
      {
        context = "Editor";
        bindings = {
          "cmd-alt-shift-up" = "editor::AddSelectionAbove";
          "cmd-alt-shift-down" = "editor::AddSelectionBelow";
        };
      }
      {
        context = "Terminal";
        bindings = {
          "ctrl-w t" = "terminal_panel::ToggleFocus";
        };
      }
    ];
  };
}
