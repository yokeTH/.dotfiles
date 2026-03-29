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
      "scss"
      "zig"
      "lua"
      "oxc"
    ];
    extraPackages = [pkgs.nixd];
    userSettings = {
      file_finder = {
        file_icons = true;
      };
      title_bar = {
        show_project_items = true;
        show_branch_name = true;
        show_branch_icon = false;
      };
      buffer_line_height = "comfortable";
      buffer_font_family = ".ZedMono";
      auto_install_extensions = {
        catppuccin = true;
        catppuccin-icons = true;
        csv = true;
        cucumber = true;
        docker-compose = true;
        dockerfile = true;
        env = true;
        git-firefly = true;
        golangci-lint = true;
        html = true;
        java = true;
        ktrz-monokai = true;
        macos-classic = true;
        make = true;
        nix = true;
        php = true;
        prisma = true;
        proto = true;
        ruby = true;
        sql = true;
        svelte = true;
        toml = true;
        verilog = true;
        vue = true;
        xml = true;
        # biome = true;
        lua = true;
        scss = true;
        zig = true;
      };
      buffer_font_size = 13;
      edit_predictions = {
        disabled_globs = ["*"];
      };
      icon_theme = {
        mode = "system";
        light = "Catppuccin Macchiato";
        dark = "Catppuccin Macchiato";
      };
      inlay_hints = {
        enabled = true;
      };
      languages = {
        Nix = {
          formatter = {
            external = {
              arguments = ["--quiet" "--"];
              command = "alejandra";
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
        TOML = {
          language_servers = ["!air.toml"];
        };
      };
      lsp = {
        oxlint = {
          initialization_options = {
            settings = {
              configPath = null;
              run = "onType";
              disableNestedConfig = false;
              fixKind = "safe_fix";
              unusedDisableDirectives = "deny";
            };
          };
        };
        oxfmt = {
          initialization_options = {
            settings = {
              "fmt.configPath" = null;
              run = "onSave";
            };
          };
        };
        rust-analyzer = {
          initialization_options = {
            inlayHints = {
              closureReturnTypeHints = {
                enable = "always";
              };
              enable = true;
              lifetimeElisionHints = {
                enable = "skip_trivial";
                useParameterNames = true;
              };
              maxLength = null;
              showTypeHints = true;
            };
          };
        };
        vtsls = {
          settings = {
            typescript = {
              preferences = {
                importModuleSpecifier = "non-relative";
              };
            };
          };
        };
        biome = {
          settings = {
            require_config_file = true;
          };
        };
      };
      preferred_line_length = 120;
      soft_wrap = "bounded";
      tabs = {
        activate_on_close = "history";
        close_position = "left";
        file_icons = true;
        git_status = true;
        show_close_button = "hover";
        show_diagnostics = "errors";
      };
      terminal = {
        dock = "bottom";
        font_family = "JetBrainsMono Nerd Font";
        font_size = 14;
      };
      theme = {
        mode = "system";
        light = "Catppuccin Macchiato";
        dark = "Catppuccin Macchiato";
      };
      ui_font_size = 16;
      ui_font_family = ".ZedSans";
      ui_font_features = {
        calt = true;
      };
      vim_mode = true;
      relative_line_numbers = "disabled";
      # disable_ai = true;
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
