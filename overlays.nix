 final: prev: {
  fzf = prev.fzf.overrideAttrs ( self: { # TODO: remove once perl is gone
    postInstall = self.postInstall + "rm $out/share/fzf/key-bindings.bash";
  });
  # TODO: nom switch FE0E -> FE0F in output for emojis
  # TODO: eza mins/secs
}
