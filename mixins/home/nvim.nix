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
      catppuccin-nvim
      nvim-colorizer-lua
      gitsigns-nvim
      nvim-web-devicons
      lspkind-nvim
      dressing-nvim
      nvim-notify
      fidget-nvim
      (gh "typicode" "bg.nvim" "61e1150dd5900eaf73700e4776088c2131585f99"
        "sha256-qzBp5h9AkJWQ3X7TSwxX881klDXojefeH0Qn/prJ/78=")
    # Fun
      (gh "Eandrju" "cellular-automaton.nvim" "b7d056dab963b5d3f2c560d92937cb51db61cb5b"
        "sha256-szbd6m7hH7NFI0UzjWF83xkpSJeUWCbn9c+O8F8S/Fg=")
      (gh "rktjmp" "playtime.nvim" "ab7d232c02341bff8479f532feec5730f8c33770"
        "sha256-gwftZrPQw9JRWed5FUSWMEHLVGo9n26HdiPrZceiQlQ=")
    # Programming
      nvim-surround
      comment-nvim
      neoformat
      nvim-lspconfig
      nvim-lint
      (nvim-treesitter.withPlugins (p: with p; [
        bash c cpp python rust lua zig kdl toml ini json json5 jq regex query
        make ninja dot nix html css scss typescript javascript markdown markdown-inline
        git-config git-rebase gitcommit gitignore udev passwd
        gdscript gdshader glsl wgsl wgsl-bevy hlsl
        typst beancount rasi yuck vim vimdoc forth asm nasm
        gn # TODO: replace with mine
      ] ++ [
        numbat-grammar
      ]))
      nvim-treesitter-textobjects nvim-treesitter-context
      vim-nix
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
  programs.neovim = nvim-config;
  xdg.configFile = {
    "nvim/queries/numbat".source = "${numbat-grammar}/queries";
  };
  home.packages = [
    pkgs.page
  ];
}
