{writeShellScriptBin}: writeShellScriptBin "get-keys" ''
cd || exit
mkdir -p .ssh
rbw config set email josephryan3.14@gmail.com
rbw get ssh_private >.ssh/id_ed25519
rbw get ssh_public >.ssh/id_ed25519.pub
chmod 644 .ssh/id_ed25519.pub
chmod 600 .ssh/id_ed25519
''
