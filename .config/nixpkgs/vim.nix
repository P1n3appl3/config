{ config, pkgs, ... }: let
  nvim_config = {
    enable = true; viAlias = true; vimAlias = true;
    withPython3 = true; withRuby = false;
    plugins = with pkgs.vimPlugins; [
      # General
      fzf-lua
      hop-nvim
      auto-session
      nvim-osc52
      vim-fetch
      impatient-nvim
      vim-startuptime
      plenary-nvim
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
      coq_nvim coq-artifacts coq-thirdparty
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
      # TODO: mfussenger/nvim-dap
    ];
  };
  vim-gn = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "vim-gn";
    src = pkgs.fetchFromGitHub {
      owner = "kalcutter";
      repo = "vim-gn";
      rev = "7dd8d21ee42ce8ab999e0326e2c131132a6be8b8";
      hash = "sha256-yEMUc5dnkOd1F0/BSPn6o6Z+C29MdFTRB6W/cqmF5bw=";
    };
  };
  nvim-treesitter-playground = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "nvim-treesitter-playground";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-treesitter";
      repo = "playground";
      rev = "4044b53c4d4fcd7a78eae20b8627f78ce7dc6f56";
      hash = "sha256-e8wqVyXfZ8qmURbCO/4pOVDSSHZEaRTGZLK5ZEh0AIY=";
    };
  };
  coq_nvim = let 
    python = pkgs.python3;
    std2 = python.pkgs.buildPythonPackage {
      name = "std2";
      src = pkgs.fetchFromGitHub {
        owner = "ms-jpq";
        repo = "std2";
        rev = "963cf22346620926c0bd64f628ff4d8141123db5";
        hash = "sha256-drW7eZKE/NmVpkZfiA7nRlgUeqNNDnKA9h1qVADDZ/s=";
      };
      format = "pyproject";
      nativeBuildInputs = [ python.pkgs.setuptools ];
    };
    pynvim_pp = python.pkgs.buildPythonPackage {
      name = "pynvim_pp";
      src = pkgs.fetchFromGitHub {
        owner = "ms-jpq";
        repo = "pynvim_pp";
        rev = "456765f6dc8cef6df39ae3e61c79585258d38517";
        hash = "sha256-edDDzxR60ILFbv1CnYGxW/sJDMeRIFPjmTeiMRdvA3k=";
      };
      format = "pyproject";
      nativeBuildInputs = [ python.pkgs.setuptools ];
      propagatedBuildInputs = [ python.pkgs.msgpack ];
    };
    pyWithDeps = python.withPackages ( p : with p; [ pyyaml std2 pynvim_pp ] );
  in pkgs.vimPlugins.coq_nvim.overrideAttrs ( prev: {
    postInstall = prev.postInstall + ''
      mkdir $out/.vars/runtime/bin -p
      # Don't check that python lives inside the venv, or that we used pip
      substituteInPlace $out/coq/__main__.py \
        --replace '_IN_VENV = _RT_PY == _EXEC_PATH' _IN_VENV=True \
        --replace 'lock != _REQ' False
      # Don't use xdg dir for python
      substituteInPlace $out/lua/coq.lua --replace 'main(is_xdg)' 'main(false)'
      # This is where it looks for python
      ln -s ${pkgs.lib.getExe pyWithDeps} $out/.vars/runtime/bin/python3
      # Check that our versions match
      { grep ${std2.src.rev} requirements.txt -q &&
      grep ${pynvim_pp.src.rev} requirements.txt -q; } ||
      { echo -e "\e[48;5;9mupdate ur hashes guy\e[0m"; exit 314; }
    '';
  });
  in { programs.neovim = nvim_config; }
