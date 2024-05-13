{ pkgs, ... }: let
  gh = owner: repo: rev: hash: pkgs.vimUtils.buildVimPlugin {
    pname = repo; version = rev;
    src = pkgs.fetchFromGitHub { inherit owner repo rev hash; };
  };
  numbat-grammar = pkgs.tree-sitter.buildGrammar {
    version = "2024-03-19"; language = "numbat";
    src = pkgs.fetchFromGitHub {
      owner = "irevoire"; repo = "tree-sitter-numbat";
      rev = "b4dd180397cad0638abbf18b54e354ea43276f46";
      hash = "sha256-QysXc0R+3HxjrdWWklrw9r8wq9gKuIRsZrMK3vh4sC0=";
    };
  };
  nvim-config = { enable = true;
    viAlias = true; vimAlias = true;
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
      dressing-nvim
      nvim-notify
      fidget-nvim
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
        gdscript wgsl wgsl_bevy beancount rasi yuck vimdoc
      ] ++ [
        pkgs.tree-sitter-grammars.tree-sitter-typst
        numbat-grammar
      ]))
      nvim-treesitter-textobjects nvim-treesitter-context
      vim-nix
      (gh "kalcutter" "vim-gn" "7dd8d21ee42ce8ab999e0326e2c131132a6be8b8"
        "sha256-yEMUc5dnkOd1F0/BSPn6o6Z+C29MdFTRB6W/cqmF5bw=")
      neodev-nvim
      rustaceanvim
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
in {
  config.programs.neovim = nvim-config;
  config.xdg.configFile = {
    "nvim/queries/numbat".source = "${numbat-grammar}/queries";
    "nvim/queries/typst".source = "${pkgs.tree-sitter-grammars.tree-sitter-typst}/queries";
  };
}
