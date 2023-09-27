{ pkgs, ... }: let
  ghPlugin = owner: repo: rev: hash: pkgs.vimUtils.buildVimPluginFrom2Nix {
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
      hover-nvim
      nvim-cmp cmp-buffer cmp-path # cmp-beancount
      # TODO: cmp-kitty and maybe cmp-under-comparator
      # TODO: nvim-ufo for folding
    # Appearance
      lush-nvim
      nvim-colorizer-lua
      gitsigns-nvim
      (ghPlugin "lukoshkin" "trailing-whitespace" "2d4aeb132973da15edbe0d093ce836563ee2aef1"
        "sha256-2LVtLuf+DUuUain9UimKJu23RG3kDKAXhOOBbITpECs=")
      nvim-web-devicons
      lspkind-nvim
      # TODO: noice-nvim or wilder.nvim lua equivalent, maybe cmp-commandline?
      nvim-notify
      dressing-nvim
      # TODO: use nixpkgs version of fidget once updated, or switch to noice
      (ghPlugin "j-hui" "fidget.nvim" "0ba1e16d07627532b6cae915cc992ecac249fb97"
      "sha256-rmJgfrEr/PYBq0S7j3tzRZvxi7PMMaAo0k528miXOQc=")
    # Programming
      nvim-surround
      comment-nvim
      nvim-autopairs
      nvim-snippy cmp-snippy vim-snippets
      neoformat # TODO: nvim-format and use lsp when available
      nvim-lspconfig
      cmp-nvim-lsp cmp-nvim-lsp-signature-help
      nvim-lint
      (nvim-treesitter.withPlugins (p: with p; [
        bash c cpp python rust lua zig kdl toml json json5 jq regex
        make ninja dot nix html css typescript javascript query
        git_config git_rebase gitcommit gitignore markdown markdown_inline
        gdscript wgsl wgsl_bevy beancount # TODO: typst, gn
      ]))
      nvim-treesitter-textobjects nvim-treesitter-context
      treesj
      vim-nix
      (ghPlugin "kalcutter" "vim-gn" "7dd8d21ee42ce8ab999e0326e2c131132a6be8b8"
        "sha256-yEMUc5dnkOd1F0/BSPn6o6Z+C29MdFTRB6W/cqmF5bw=")
      (ghPlugin "fladson" "vim-kitty" "891475671feebc4bf0f29f0a0987067913a81686"
        "sha256-eQa1bEapY06ImpDva5+i0WQxQK3AYdHhM1FTXwNc/HU=")
      neodev-nvim
      rust-tools-nvim crates-nvim
      # TODO: nvim-dap + cmp-dap
    ];
  };
in { config.programs.neovim = nvim_config; }
