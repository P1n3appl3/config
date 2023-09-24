 final: prev: {
  fzf = prev.fzf.overrideAttrs ( self: { # TODO: remove once perl is gone
    postInstall = self.postInstall + "rm $out/share/fzf/key-bindings.bash";
  });
  # TODO: add overlay for eza icons until they have a config file
}
