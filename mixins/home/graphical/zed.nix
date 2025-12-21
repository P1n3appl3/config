{
  programs.zed-editor = {
    enable = true;

    userSettings = {
        ui_font_size = 18.0;
        which_key = { enabled = true; delay_ms = 200; };
        restore_on_startup = "launchpad";
        theme = "Catppuccin Mocha (blue)";
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
          theme = "Catppuccin Mocha (blue)";
        };
        linux = {
          theme = "Catppuccin Mocha";
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

    themes.catppucin-blue = {
      name = "Catppuccin Blue";
      author = "Catppuccin and julia";
      themes = [ {
        name = "Catppuccin Mocha (blue)";
        appearance = "dark";
        style = {
          accents = [
            "#cbb0f766"
            "#b9c3fc66"
            "#86caee66"
            "#aee1b266"
            "#f0e0bd66"
            "#f1ba9d66"
            "#eb9ab766"
          ];
          "background.appearance" = "opaque";
          border = "#313244";
          "border.variant" = "#789ad6";
          "border.focused" = "#b4befe";
          "border.selected" = "#89b4fa";
          "border.transparent" = "#a6e3a1";
          "border.disabled" = "#6c7086";
          "elevated_surface.background" = "#181825";
          "surface.background" = "#181825";
          background = "#27273b";
          "element.background" = "#11111b";
          "element.hover" = "#45475a4d";
          "element.active" = "#585b704d";
          "element.selected" = "#3132444d";
          "element.disabled" = "#6c7086";
          "drop_target.background" = "#31324466";
          "ghost_element.background" = "#00000000";
          "ghost_element.hover" = "#45475a4d";
          "ghost_element.active" = "#585b7099";
          "ghost_element.selected" = "#6f728d66";
          "ghost_element.disabled" = "#6c7086";
          text = "#cdd6f4";
          "text.muted" = "#bac2de";
          "text.placeholder" = "#585b70";
          "text.disabled" = "#45475a";
          "text.accent" = "#89b4fa";
          icon = "#cdd6f4";
          "icon.muted" = "#7f849c";
          "icon.disabled" = "#6c7086";
          "icon.placeholder" = "#585b70";
          "icon.accent" = "#89b4fa";
          "status_bar.background" = "#11111b";
          "title_bar.background" = "#11111b";
          "title_bar.inactive_background" = "#11111bd9";
          "toolbar.background" = "#1e1e2e";
          "tab_bar.background" = "#11111b";
          "tab.inactive_background" = "#0b0b11";
          "tab.active_background" = "#1e1e2e";
          "search.match_background" = "#94e2d533";
          "panel.background" = "#181825";
          "panel.focused_border" = "#cdd6f4";
          "panel.indent_guide" = "#31324499";
          "panel.indent_guide_active" = "#585b70";
          "panel.indent_guide_hover" = "#89b4fa";
          "pane.focused_border" = "#cdd6f4";
          "pane_group.border" = "#313244";
          "scrollbar.thumb.background" = "#89b4fa33";
          "scrollbar.thumb.hover_background" = "#6c7086";
          "scrollbar.thumb.border" = "#89b4fa";
          "scrollbar.track.background" = null;
          "scrollbar.track.border" = "#cdd6f412";
          "editor.foreground" = "#cdd6f4";
          "editor.background" = "#1e1e2e";
          "editor.gutter.background" = "#1e1e2e";
          "editor.subheader.background" = "#181825";
          "editor.active_line.background" = "#cdd6f40f";
          "editor.highlighted_line.background" = null;
          "editor.line_number" = "#7f849c";
          "editor.active_line_number" = "#89b4fa";
          "editor.invisible" = "#9399b266";
          "editor.wrap_guide" = "#585b70";
          "editor.active_wrap_guide" = "#585b70";
          "editor.document_highlight.bracket_background" = "#89b4fa17";
          "editor.document_highlight.read_background" = "#a6adc829";
          "editor.document_highlight.write_background" = "#a6adc829";
          "editor.indent_guide" = "#31324499";
          "editor.indent_guide_active" = "#585b70";
          "terminal.background" = "#1e1e2e";
          "terminal.ansi.background" = "#1e1e2e";
          "terminal.foreground" = "#cdd6f4";
          "terminal.dim_foreground" = "#7f849c";
          "terminal.bright_foreground" = "#cdd6f4";
          "terminal.ansi.black" = "#45475a";
          "terminal.ansi.red" = "#f38ba8";
          "terminal.ansi.green" = "#a6e3a1";
          "terminal.ansi.yellow" = "#f9e2af";
          "terminal.ansi.blue" = "#89b4fa";
          "terminal.ansi.magenta" = "#f5c2e7";
          "terminal.ansi.cyan" = "#94e2d5";
          "terminal.ansi.white" = "#bac2de";
          "terminal.ansi.bright_black" = "#585b70";
          "terminal.ansi.bright_red" = "#f38ba8";
          "terminal.ansi.bright_green" = "#a6e3a1";
          "terminal.ansi.bright_yellow" = "#f9e2af";
          "terminal.ansi.bright_blue" = "#89b4fa";
          "terminal.ansi.bright_magenta" = "#f5c2e7";
          "terminal.ansi.bright_cyan" = "#94e2d5";
          "terminal.ansi.bright_white" = "#a6adc8";
          "terminal.ansi.dim_black" = "#45475a";
          "terminal.ansi.dim_red" = "#f38ba8";
          "terminal.ansi.dim_green" = "#a6e3a1";
          "terminal.ansi.dim_yellow" = "#f9e2af";
          "terminal.ansi.dim_blue" = "#89b4fa";
          "terminal.ansi.dim_magenta" = "#f5c2e7";
          "terminal.ansi.dim_cyan" = "#94e2d5";
          "terminal.ansi.dim_white" = "#bac2de";
          "link_text.hover" = "#89dceb";
          conflict = "#fab387";
          "conflict.border" = "#fab387";
          "conflict.background" = "#fab38726";
          created = "#a6e3a1";
          "created.border" = "#a6e3a1";
          "created.background" = "#a6e3a126";
          deleted = "#f38ba8";
          "deleted.border" = "#f38ba8";
          "deleted.background" = "#f38ba826";
          hidden = "#6c7086";
          "hidden.border" = "#6c7086";
          "hidden.background" = "#181825";
          hint = "#7c7f98";
          "hint.border" = "#585b70";
          "hint.background" = "#181825";
          ignored = "#6c7086";
          "ignored.border" = "#6c7086";
          "ignored.background" = "#6c708626";
          modified = "#f9e2af";
          "modified.border" = "#f9e2af";
          "modified.background" = "#f9e2af26";
          predictive = "#6c7086";
          "predictive.border" = "#b4befe";
          "predictive.background" = "#181825";
          renamed = "#74c7ec";
          "renamed.border" = "#74c7ec";
          "renamed.background" = "#74c7ec26";
          info = "#94e2d5";
          "info.border" = "#94e2d5";
          "info.background" = "#9399b233";
          warning = "#f9e2af";
          "warning.border" = "#f9e2af";
          "warning.background" = "#f9e2af1f";
          error = "#f38ba8";
          "error.border" = "#f38ba8";
          "error.background" = "#f38ba81f";
          success = "#a6e3a1";
          "success.border" = "#a6e3a1";
          "success.background" = "#a6e3a11f";
          unreachable = "#f38ba8";
          "unreachable.border" = "#f38ba8";
          "unreachable.background" = "#f38ba81f";
          players = [
            {
              cursor = "#f5e0dc";
              selection = "#585b7080";
              background = "#f5e0dc";
            }
            {
              cursor = "#cbb0f7";
              selection = "#cbb0f733";
              background = "#cbb0f7";
            }
            {
              cursor = "#b9c3fc";
              selection = "#b9c3fc33";
              background = "#b9c3fc";
            }
            {
              cursor = "#86caee";
              selection = "#86caee33";
              background = "#86caee";
            }
            {
              cursor = "#aee1b2";
              selection = "#aee1b233";
              background = "#aee1b2";
            }
            {
              cursor = "#f0e0bd";
              selection = "#f0e0bd33";
              background = "#f0e0bd";
            }
            {
              cursor = "#f1ba9d";
              selection = "#f1ba9d33";
              background = "#f1ba9d";
            }
            {
              cursor = "#eb9ab7";
              selection = "#eb9ab733";
              background = "#eb9ab7";
            }
          ];
          "version_control.added" = "#a6e3a1";
          "version_control.added_background" = "$a6e3a126";
          "version_control.deleted" = "#f38ba8";
          "version_control.deleted_background" = "#f38ba826";
          "version_control.modified" = "#f9e2af";
          "version_control.modified_background" = "#f9e2af26";
          "version_control.renamed" = "#74c7ec";
          "version_control.conflict" = "#fab387";
          "version_control.conflict_background" = "#fab38726";
          "version_control.ignored" = "#6c7086";
          syntax = {
            variable = {
              color = "#cdd6f4";
            };
            "variable.builtin" = {
              color = "#f38ba8";
            };
            "variable.parameter" = {
              color = "#eba0ac";
            };
            "variable.member" = {
              color = "#89b4fa";
            };
            "variable.special" = {
              color = "#f38ba8";
              "font_style" = "italic";
            };
            constant = {
              color = "#fab387";
            };
            "constant.builtin" = {
              color = "#fab387";
            };
            "constant.macro" = {
              color = "#cba6f7";
            };
            module = {
              color = "#f9e2af";
              "font_style" = "italic";
            };
            label = {
              color = "#74c7ec";
            };
            string = {
              color = "#a6e3a1";
            };
            "string.documentation" = {
              color = "#94e2d5";
            };
            "string.regexp" = {
              color = "#fab387";
            };
            "string.escape" = {
              color = "#f5c2e7";
            };
            "string.special" = {
              color = "#f5c2e7";
            };
            "string.special.path" = {
              color = "#f5c2e7";
            };
            "string.special.symbol" = {
              color = "#f2cdcd";
            };
            "string.special.url" = {
              color = "#f5e0dc";
              "font_style" = "italic";
            };
            character = {
              color = "#94e2d5";
            };
            "character.special" = {
              color = "#f5c2e7";
            };
            boolean = {
              color = "#fab387";
            };
            number = {
              color = "#fab387";
            };
            "number.float" = {
              color = "#fab387";
            };
            type = {
              color = "#f9e2af";
            };
            "type.builtin" = {
              color = "#cba6f7";
              "font_style" = "italic";
            };
            "type.definition" = {
              color = "#f9e2af";
            };
            "type.interface" = {
              color = "#f9e2af";
              "font_style" = "italic";
            };
            "type.super" = {
              color = "#f9e2af";
              "font_style" = "italic";
            };
            attribute = {
              color = "#fab387";
            };
            property = {
              color = "#89b4fa";
            };
            function = {
              color = "#89b4fa";
            };
            "function.builtin" = {
              color = "#fab387";
            };
            "function.call" = {
              color = "#89b4fa";
            };
            "function.macro" = {
              color = "#94e2d5";
            };
            "function.method" = {
              color = "#89b4fa";
            };
            "function.method.call" = {
              color = "#89b4fa";
            };
            constructor = {
              color = "#f2cdcd";
            };
            operator = {
              color = "#89dceb";
            };
            keyword = {
              color = "#cba6f7";
            };
            "keyword.modifier" = {
              color = "#cba6f7";
            };
            "keyword.type" = {
              color = "#cba6f7";
            };
            "keyword.coroutine" = {
              color = "#cba6f7";
            };
            "keyword.function" = {
              color = "#cba6f7";
            };
            "keyword.operator" = {
              color = "#cba6f7";
            };
            "keyword.import" = {
              color = "#cba6f7";
            };
            "keyword.repeat" = {
              color = "#cba6f7";
            };
            "keyword.return" = {
              color = "#cba6f7";
            };
            "keyword.debug" = {
              color = "#cba6f7";
            };
            "keyword.exception" = {
              color = "#cba6f7";
            };
            "keyword.conditional" = {
              color = "#cba6f7";
            };
            "keyword.conditional.ternary" = {
              color = "#cba6f7";
            };
            "keyword.directive" = {
              color = "#f5c2e7";
            };
            "keyword.directive.define" = {
              color = "#f5c2e7";
            };
            "keyword.export" = {
              color = "#89dceb";
            };
            punctuation = {
              color = "#9399b2";
            };
            "punctuation.delimiter" = {
              color = "#9399b2";
            };
            "punctuation.bracket" = {
              color = "#9399b2";
            };
            "punctuation.special" = {
              color = "#f5c2e7";
            };
            "punctuation.special.symbol" = {
              color = "#f2cdcd";
            };
            "punctuation.list_marker" = {
              color = "#94e2d5";
            };
            comment = {
              color = "#9399b2";
              "font_style" = "italic";
            };
            "comment.doc" = {
              color = "#9399b2";
              "font_style" = "italic";
            };
            "comment.documentation" = {
              color = "#9399b2";
              "font_style" = "italic";
            };
            "comment.error" = {
              color = "#f38ba8";
              "font_style" = "italic";
            };
            "comment.warning" = {
              color = "#f9e2af";
              "font_style" = "italic";
            };
            "comment.hint" = {
              color = "#89b4fa";
              "font_style" = "italic";
            };
            "comment.todo" = {
              color = "#f2cdcd";
              "font_style" = "italic";
            };
            "comment.note" = {
              color = "#f5e0dc";
              "font_style" = "italic";
            };
            "diff.plus" = {
              color = "#a6e3a1";
            };
            "diff.minus" = {
              color = "#f38ba8";
            };
            tag = {
              color = "#89b4fa";
            };
            "tag.attribute" = {
              color = "#f9e2af";
              "font_style" = "italic";
            };
            "tag.delimiter" = {
              color = "#94e2d5";
            };
            parameter = {
              color = "#eba0ac";
            };
            field = {
              color = "#b4befe";
            };
            namespace = {
              color = "#f9e2af";
              "font_style" = "italic";
            };
            float = {
              color = "#fab387";
            };
            symbol = {
              color = "#f5c2e7";
            };
            "string.regex" = {
              color = "#fab387";
            };
            text = {
              color = "#cdd6f4";
            };
            "emphasis.strong" = {
              color = "#eba0ac";
              "font_weight" = 700;
            };
            emphasis = {
              color = "#eba0ac";
              "font_style" = "italic";
            };
            embedded = {
              color = "#eba0ac";
            };
            "text.literal" = {
              color = "#a6e3a1";
            };
            concept = {
              color = "#74c7ec";
            };
            enum = {
              color = "#94e2d5";
              "font_weight" = 700;
            };
            "function.decorator" = {
              color = "#fab387";
            };
            "type.class.definition" = {
              color = "#f9e2af";
              "font_weight" = 700;
            };
            hint = {
              color = "#585b70";
              "font_style" = "italic";
            };
            "link_text" = {
              color = "#b4befe";
            };
            "link_uri" = {
              color = "#89b4fa";
            };
            parent = {
              color = "#fab387";
            };
            predictive = {
              color = "#6c7086";
            };
            predoc = {
              color = "#f38ba8";
            };
            primary = {
              color = "#eba0ac";
            };
            "tag.doctype" = {
              color = "#cba6f7";
            };
            "string.doc" = {
              color = "#94e2d5";
            };
            title = {
              color = "#cdd6f4";
            };
            variant = {
              color = "#f38ba8";
            };
          };
        };
      }
      ];
    };
  };
}
