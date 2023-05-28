{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    fzf-lua = {
      url = "github:ibhagwan/fzf-lua";
      flake = false;
    };
    nvim-treesitter-playground = {
      url = "github:nvim-treesitter/nvim-treesitter-playground";
      flake = false;
    };
    vim-gn = {
      url = "github:kalcutter/vim-gn";
      flake = false;
    };

  };

  outputs = { nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        np = nixpkgs.legacyPackages.${system};
        inherit (np.vimUtils) buildVimPluginFrom2Nix;
      in rec {
        packages = vimPlugins;
        vimPlugins = {

          fzf-lua = np.vimPlugins.fzf-lua.overrideAttrs
            (self: { src = inputs.fzf-lua; });

          vim-gn = buildVimPluginFrom2Nix {
            pname = "vim-gn";
            version = inputs.vim-gn.lastModifiedDate;
            src = inputs.vim-gn;
          };

          nvim-treesitter-playground = buildVimPluginFrom2Nix {
            pname = "nvim-treesitter-playground";
            version = inputs.nvim-treesitter-playground.lastModifiedDate;
            src = inputs.nvim-treesitter-playground;
          };

        };
      });
}
