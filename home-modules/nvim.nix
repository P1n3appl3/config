{ pkgs, ... }: let
  gh = owner: repo: rev: hash: pkgs.vimUtils.buildVimPlugin {
    pname = repo; version = rev;
    src = pkgs.fetchFromGitHub { inherit owner repo rev hash; };
  };
  nvim-config = {
    enable = true; viAlias = true; vimAlias = true;
    withPython3 = true; withRuby = false;
    plugins = with pkgs.vimPlugins; [
    # General
      which-key-nvim
      nvim-osc52
      vim-fetch
      vim-startuptime
      plenary-nvim
    # Appearance
      lush-nvim
      nvim-colorizer-lua
      gitsigns-nvim
      nvim-web-devicons
      lspkind-nvim
      nvim-notify
      dressing-nvim
      (gh "j-hui" "fidget.nvim" "0ba1e16d07627532b6cae915cc992ecac249fb97"
        "sha256-rmJgfrEr/PYBq0S7j3tzRZvxi7PMMaAo0k528miXOQc=")
      (gh "Eandrju" "cellular-automaton.nvim" "b7d056dab963b5d3f2c560d92937cb51db61cb5b"
        "sha256-szbd6m7hH7NFI0UzjWF83xkpSJeUWCbn9c+O8F8S/Fg=")
    # Programming
      nvim-surround
      comment-nvim
      neoformat
      nvim-lspconfig
      nvim-lint
      (nvim-treesitter.withPlugins (p: with p; [
        bash c cpp python rust lua zig kdl toml json json5 jq regex
        make ninja dot nix html css typescript javascript query
        git_config git_rebase gitcommit gitignore markdown markdown_inline
        gdscript wgsl wgsl_bevy beancount rasi yuck
      ] ++ [
        pkgs.tree-sitter-grammars.tree-sitter-typst
        (pkgs.tree-sitter.buildGrammar rec {
          version = "v1.1.0"; language = "hypr";
          src = pkgs.fetchFromGitHub {
            owner = "luckasRanarison"; repo = "tree-sitter-hypr"; rev = version;
            hash = "sha256-P3ZiIurixNdBqKJrsmFibmScnwD0pjhljLo4L8BLtws=";
          };
        })
      ]))
      nvim-treesitter-textobjects nvim-treesitter-context
      vim-nix
      (gh "kalcutter" "vim-gn" "7dd8d21ee42ce8ab999e0326e2c131132a6be8b8"
        "sha256-yEMUc5dnkOd1F0/BSPn6o6Z+C29MdFTRB6W/cqmF5bw=")
      (gh "fladson" "vim-kitty" "891475671feebc4bf0f29f0a0987067913a81686"
        "sha256-eQa1bEapY06ImpDva5+i0WQxQK3AYdHhM1FTXwNc/HU=")
      neodev-nvim
      rust-tools-nvim
      nvim-autopairs
      nvim-cmp
      nvim-snippy cmp-snippy vim-snippets
      cmp-buffer cmp-path # cmp-beancount
      cmp-nvim-lsp cmp-nvim-lsp-signature-help
    ] ++ map (p: { plugin = p; optional = true; }) [ # lazy loaded plugins
      fzf-lua
      hop-nvim
      treesj
    ];
  };
in { config.programs.neovim = nvim-config; }
