{ pkgs, ... }: let
  nvim_config = {
    enable = true; viAlias = true; vimAlias = true;
    withPython3 = true; withRuby = false;
    plugins = with pkgs.vimPlugins; [
      # General
      fzf-lua hop-nvim auto-session nvim-osc52 vim-fetch vim-startuptime plenary-nvim
      # Pretty
      lush-nvim nvim-colorizer-lua gitsigns-nvim nvim-web-devicons
      # Programming
      nvim-surround
      comment-nvim
      nvim-autopairs
      neoformat # TODO: nvim-format and use lsp when available
      nvim-lspconfig
      nvim-lint
      fidget-nvim
      coq_nvim coq-artifacts # TODO: can't ls/edit snippets? try cmp?
      (nvim-treesitter.withPlugins (p: with p; [
        bash c cpp python rust lua zig kdl json toml json json5 
        make ninja dot nix latex html css typescript javascript
      ]))
      nvim-treesitter-textobjects nvim-treesitter-context nvim-treesitter-playground
      vim-nix
      vim-gn
      neodev-nvim
      rust-tools-nvim
      # TODO: imsnif/kdl.vim if it's better than treesitter
      # TODO: mfussenger/nvim-dap with lldb for rust
    ];
  };
  # TODO: remove once nixpkgs updates
  fzf-lua = pkgs.vimPlugins.fzf-lua.overrideAttrs (self: {
    src = pkgs.fetchFromGitHub {
      owner = "ibhagwan"; repo = self.pname;
      rev = "bc5110738d44c16655cf1b23534343aaade855a2";
      hash = "sha256-7QiUTTfCCfjnWDC9MxZOdU9zIQ24Xm9OgfHG8FoRDoI=";
    };
  });
  vim-gn = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "vim-gn";
    src = pkgs.fetchFromGitHub {
      owner = "kalcutter"; repo = "vim-gn";
      rev = "7dd8d21ee42ce8ab999e0326e2c131132a6be8b8";
      hash = "sha256-yEMUc5dnkOd1F0/BSPn6o6Z+C29MdFTRB6W/cqmF5bw=";
    };
  };
  nvim-treesitter-playground = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "nvim-treesitter-playground";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-treesitter"; repo = "playground";
      rev = "4044b53c4d4fcd7a78eae20b8627f78ce7dc6f56";
      hash = "sha256-e8wqVyXfZ8qmURbCO/4pOVDSSHZEaRTGZLK5ZEh0AIY=";
    };
  };
  in { programs.neovim = nvim_config; }
