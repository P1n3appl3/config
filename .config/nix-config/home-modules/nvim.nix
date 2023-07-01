{ pkgs, ... }: let
  gitPlugin = owner: repo: rev: hash: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${repo}"; version = rev;
    src = pkgs.fetchFromGitHub { inherit owner repo rev hash; };
  };
  nvim_config = {
    enable = true; viAlias = true; vimAlias = true;
    withPython3 = true; withRuby = false;
    plugins = with pkgs.vimPlugins; [
    # General
      fzf-lua
      hop-nvim
      which-key-nvim
      auto-session
      nvim-osc52 # TODO: gbprod/yanky.nvim
      vim-fetch
      vim-startuptime
      plenary-nvim
      coq_nvim coq-artifacts # TODO: can't ls/edit snippets? try cmp?
      # TODO: nvim-ufo for folding
      (gitPlugin "lewis6991" "hover.nvim" "7aed88b45b5f5a201a78b4393144fef9c88f37f7"
        "sha256-Neb82orSyF/y00qDHYbTYm9rJK79yVBAAF7k7UcjcQg=")
    # Appearance
      lush-nvim
      nvim-colorizer-lua
      gitsigns-nvim
      (gitPlugin "lukoshkin" "trailing-whitespace" "2d4aeb132973da15edbe0d093ce836563ee2aef1"
        "sha256-2LVtLuf+DUuUain9UimKJu23RG3kDKAXhOOBbITpECs=")
      nvim-web-devicons
      # TODO: noice-nvim or wilder.nvim lua equivalent, maybe cmp-commandline?
      nvim-notify
      dressing-nvim
      # TODO: use nixpkgs version of fidget once updated, or switch to noice
      (gitPlugin "j-hui" "fidget.nvim" "0ba1e16d07627532b6cae915cc992ecac249fb97"
      "sha256-rmJgfrEr/PYBq0S7j3tzRZvxi7PMMaAo0k528miXOQc=")
    # Programming
      nvim-surround
      comment-nvim
      nvim-autopairs
      neoformat # TODO: nvim-format and use lsp when available
      nvim-lspconfig
      nvim-lint
      (nvim-treesitter.withPlugins (p: with p; [
        bash c cpp python rust lua zig kdl toml json json5 jq regex
        make ninja dot nix html css typescript javascript query
        git_config git_rebase gitcommit gitignore markdown markdown_inline
        gdscript wgsl wgsl_bevy # TODO: typst, gn
      ]))
      nvim-treesitter-textobjects
      nvim-treesitter-context
      treesj
      vim-nix
      (gitPlugin "kalcutter" "vim-gn" "7dd8d21ee42ce8ab999e0326e2c131132a6be8b8"
        "sha256-yEMUc5dnkOd1F0/BSPn6o6Z+C29MdFTRB6W/cqmF5bw=")
      neodev-nvim
      rust-tools-nvim
      # TODO: nvim-dap
    ];
  };
in { config.programs.neovim = nvim_config; }
