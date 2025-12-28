{
  programs.zed-editor = {
    enable = true;

    userSettings = {
        ui_font_size = 18.0;
        which_key = { enabled = true; delay_ms = 200; };
        restore_on_startup = "launchpad";
        helix_mode = false;
        hover_popover_delay = 300;
        drag_and_drop_selection = {
          delay = 300;
        };
        scroll_sensitivity = 1.0;
        on_last_window_closed = "platform_default";
        confirm_quit = true;
        base_keymap = "VSCode";
        use_system_path_prompts = false;
        git_panel = { dock = "right"; };
        collaboration_panel = { dock = "right"; };
        outline_panel = { dock = "right"; };
        project_panel = { dock = "right"; };
        debugger = { dock = "bottom"; };
        bottom_dock_layout = "full";
        toolbar = {
          selections_menu = false;
          quick_actions = false;
        };
        tab_bar = {
          show = false;
          show_nav_history_buttons = false;
          show_tab_bar_buttons = false;
        };
        tabs = { git_status = true; };
        preview_tabs = {
          enabled = false;
          enable_keep_preview_on_code_navigation = true;
        };
        vertical_scroll_margin = 0;
        icon_theme = "Catppuccin Mocha";
        gutter = {
          line_numbers = false;
          folds = false;
          breakpoints = false;
        };
        inline_code_actions = false;
        lsp_document_colors = "inlay";
        minimap = {
          thumb = "always";
          show = "never";
          current_line_highlight = "gutter";
        };
        current_line_highlight = "gutter";
        indent_guides = { enabled = false; };
        title_bar = {
          show_sign_in = false;
          show_user_picture = false;
          show_branch_icon = true;
        };
        sticky_scroll = {
          enabled = true;
        };
        "experimental.theme_overrides" = {
          "editor.gutter.background" = "#2e2e3e";
        };
        vim_mode = true;
        vim = {
          use_system_clipboard = "on_yank";
        };
        load_direnv = "shell_hook";
        terminal = {
          blinking = "on";
          cursor_shape = "bar";
          line_height = "standard";
          dock = "right";
          env = {
            GIT_EDITOR = "zed --wait";
          };
        };
        format_on_save = "off";
        middle_click_paste = false;
        inlay_hints = {
          edit_debounce_ms = 700;
          toggle_on_modifiers_press = {
            alt = true;
          };
        };
        audio = {
          "experimental.rodio_audio" = true;
          "experimental.denoise" = true;
          "experimental.auto_speaker_volume" = true;
        };
        search = { regex = true; button = false; };
        languages = {
          Rust = {
            linked_edits = true;
            soft_wrap = "editor_width";
          };
          Nix = {
            soft_wrap = "editor_width";
            tab_size = 2;
            language_servers = [ "nil" "!nixd" ];
          };
          TestLSP = {
            language_servers = [
              "test-lsp"
            ];
          };
        };
        lsp = {
          "rust-analyzer" = {
            initialization_options = {
              cargo = {
                features = "all";
              };
              checkOnSave = true;
              check = {
                workspace = true;
              };
              diagnostics = {
                enable = false;
              };
            };
          };
          nil = {
            initialization_options = {
              formatting = {
                command = [ "nixfmt" ];
              };
            };
          };
        };
        auto_install_extensions = {
          catppuccin = true;
          "catppuccin-icons" = true;
          "git-firefly" = true;
          html = true;
          toml = true;
          nix = true;
          lua = true;
          kdl = true;
          assembly = true;
          typst = true;
          "color-highlight" = true;
        };
        file_types = { };

        macos = {
          ui_font_size = 13;
          buffer_font_size = 12.0;
          buffer_font_family = "Source Code Pro";
          buffer_font_features = {
            calt = true;
          };
          preferred_line_length = 92;
          buffer_line_height = "standard";
        };
        dev = {
          search = {

          };
          session = {
            trust_all_worktrees = true;
          };
          "experimental.theme_overrides" = {
            "title_bar.background" = "#903050";
          };
        };
        nightly = {
          "experimental.theme_overrides" = {
            "version_control.ignored" = "#123456";
          };
        };
        preview = {
          "experimental.theme_overrides" = {
            "title_bar.background" = "#397CE1";
          };
        };
        stable = {

        };
    };
  };
}
