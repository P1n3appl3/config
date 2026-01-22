{ pkgs, ... }: let
  gh = owner: repo: rev: hash: pkgs.vimUtils.buildVimPlugin {
    pname = repo; version = rev;
    src = pkgs.fetchFromGitHub { inherit owner repo rev hash; };
    doCheck = false;
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
    viAlias = true; vimAlias = false;
    withPython3 = true; withRuby = false;
    plugins = with pkgs.vimPlugins; [
    # General
      which-key-nvim
      nvim-osc52
      vim-fetch
      vim-startuptime
      plenary-nvim
      bigfile-nvim
      (gh "lowitea" "aw-watcher.nvim" "790ec9e66415d8703c15f78ab567890e122c47e5"
        "sha256-GtHHUoI+dDdECK46JzZdJLTp/f1hXRuGn+uKP2FOqQA=")
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
      (gh "3rd" "image.nvim" "b991fc7f845bc6ab40c6ec00b39750dcd5190010"
        "sha256-Sjbmf4BmjkjAorT3tojbC7JivJagFamAVgzwcCipa8k=")
    # Fun
      (gh "Eandrju" "cellular-automaton.nvim" "11aea08aa084f9d523b0142c2cd9441b8ede09ed"
        "sha256-nIv7ISRk0+yWd1lGEwAV6u1U7EFQj/T9F8pU6O0Wf0s=")
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
      rustaceanvim
      nvim-autopairs
      nvim-cmp
      nvim-snippy cmp-snippy vim-snippets
      cmp-buffer cmp-path # cmp-beancount
      cmp-nvim-lsp cmp-nvim-lsp-signature-help
      nvim-dap nvim-dap-ui nvim-dap-virtual-text cmp-dap
      nvim-dap-python nvim-dap-rr
    ] ++ map (p: { plugin = p; optional = true; }) [ # lazy loaded plugins
      fzf-lua
      hop-nvim
      treesj
    ];

    # used by image.nvim
    extraPackages = [ pkgs.imagemagick ]; extraLuaPackages = ps: [ ps.magick ];
  };
in {
  programs.neovim = nvim-config;
  xdg.configFile = {
    "nvim/init.lua".enable = false;
    "nvim/queries/numbat".source = "${numbat-grammar}/queries";
    "nvim/syntax/vasm.vim".source = pkgs.fetchzip {
      url = "https://gist.github.com/porglezomp/690bb0f75883dc69350174b576ad643f/archive/fd0f08a6b45187123d9af450307f7836fc35bd4d.zip";
      hash = "sha256-0q028/gsHWPw2t9LUDf/Okg0ac127pONu3BGd9LjDNI=";
    } + "/hovalaag.vim";
  };
  home.packages = with pkgs; [ page ];
}
