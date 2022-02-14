#!/bin/zsh

minecraft_mods=(
    G1epq3jN # advancement info
    1IjD5062 # continuity
    P7dR8mSH # fabric api
    349239   # carpet
    Orvt0mRa # indium
    308892   # litematica
    gvQqBUqZ # lithium
    244260   # minihud
    mOgUt4GM # mod menu
    296468   # no fog
    hEOCdOgW # phosphor
    AANobbMI # sodium
    297344   # tweakeroo
    225608   # world edit
)
fabric-installer client -dir .minecraft
pacmc init
for mod in $minecraft_mods; do
    pacmc install $mod
done
