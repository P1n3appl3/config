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
      nvim-osc52
      vim-fetch
      vim-startuptime
      plenary-nvim
      coq_nvim coq-artifacts # TODO: can't ls/edit snippets? try cmp?
      # TODO: wilder.nvim lua equivalent, maybe cmp-commandline?
      (gitPlugin "lewis6991" "hover.nvim" "7aed88b45b5f5a201a78b4393144fef9c88f37f7"
        "sha256-Neb82orSyF/y00qDHYbTYm9rJK79yVBAAF7k7UcjcQg=")
    # Appearance
      lush-nvim
      nvim-colorizer-lua
      gitsigns-nvim
      (gitPlugin "lukoshkin" "trailing-whitespace" "2d4aeb132973da15edbe0d093ce836563ee2aef1"
        "sha256-2LVtLuf+DUuUain9UimKJu23RG3kDKAXhOOBbITpECs=")
      nvim-web-devicons
      dressing-nvim
      nvim-notify
    # Programming
      nvim-surround
      comment-nvim
      nvim-autopairs
      neoformat # TODO: nvim-format and use lsp when available
      nvim-lspconfig
      nvim-lint
      fidget-nvim
      (nvim-treesitter.withPlugins (p: with p; [
        bash c cpp python rust lua zig kdl json toml json json5
        make ninja dot nix latex html css typescript javascript
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
