 final: prev: {
  fzf = prev.fzf.overrideAttrs ( self: {
  postInstall = self.postInstall + ''
      rm $out/share/fzf/key-bindings.bash # TODO: remove once perl is gone
      rm $out/share/nvim/site/plugin/fzf.vim
    '';
  });
  # TODO: nom switch FE0E -> FE0F in output for emojis
  # TODO: eza mins/secs
}
