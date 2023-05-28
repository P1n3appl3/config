{ pkgs, inputs, ... }: let
  nvim_config = {
    enable = true; viAlias = true; vimAlias = true;
    withPython3 = true; withRuby = false;
    plugins = with pkgs.vimPlugins; [
      # General
      # fzf-lua 
      hop-nvim auto-session nvim-osc52 vim-fetch vim-startuptime plenary-nvim
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
      nvim-treesitter-textobjects nvim-treesitter-context
      vim-nix
      # vim-gn
      neodev-nvim
      rust-tools-nvim
      # TODO: imsnif/kdl.vim if it's better than treesitter
      # TODO: mfussenger/nvim-dap with lldb for rust
    ] ++ (builtins.attrValues 
    inputs.vim-plugins.vimPlugins.${pkgs.stdenv.hostPlatform.system});
  };
  nixPlugins = ["fzf-lua"];
  g = o: r: {owner=o; repo=r;};
  githubPlugins = [
    (g "kalcutter" "vim-gn")
    (g "nvim-treesitter" "nvim-treesitter-playground")
];
in {
  config.programs.neovim = nvim_config;
  config.myVimPlugins = { inherit nixPlugins githubPlugins; };
  options.myVimPlugins = pkgs.lib.mkOption {};
}
