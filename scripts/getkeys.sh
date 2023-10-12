#!/usr/bin/env bash

cd || exit

mkdir -p .ssh
rbw config set email josephryan3.14@gmail.com
rbw get ssh_private >.ssh/id_rsa
rbw get ssh_public >.ssh/id_rsa.pub
chmod 644 .ssh/id_rsa.pub
chmod 600 .ssh/id_rsa
chmod 700 .ssh

echo export OPENWEATHERMAP_API_KEY="$(rbw get openweathermap)" >>.xprofile

