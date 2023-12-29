# overlays let you override packages in your instance of nixpkgs. A neat property they
# have is that other packages that rely on something you override will use the overridden
# version. Like in my config I patch fzf, but I also have a bunch of software that embeds
# fzf like vim plugins and stuff, and I don't have to go mess with any of those to get them
# to use my overrides because from their point of view they're just getting the normal fzf
# they asked for from nixpkgs.
inputs: final: prev: {

  # this overlay applies a super simple replacement to give you prettier output when you
  # rebuild your home configuration by using the nix-output-monitor wrapper
  home-manager = prev.home-manager.overrideAttrs (old: {
    postInstall = ''
      substituteInPlace $out/bin/home-manager --replace "nix build" "nom build"
    '';
  });

  # it's also super easy to do stuff like overriding the version of a package or applying
  # your own patches from a fork, here's an example of the latter:
  eza = prev.eza.overrideAttrs (old: {
    patches = (old.patches or []) ++ [
      (final.fetchpatch {
        url = "https://github.com/eza-community/eza/compare/main...P1n3appl3:eza:main.diff";
        hash = "sha256-TZnwIM8S4c0WeJtLEG1tFoKhqgMcE9top1S7Z7s9LeA="; })
    ];
    doCheck = false;
  });
}
