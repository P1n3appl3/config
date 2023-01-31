#!/bin/bash

cd "$TR_TORRENT_DIR"
fd -F "$TR_TORRENT_NAME" -x ouch d {} -o {/.}
