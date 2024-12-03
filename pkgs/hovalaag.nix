{ writeShellApplication, fetchzip, winePackages, samba }: writeShellApplication (let
  src = fetchzip {
    url = "http://silverspaceship.com/hovalaag/hovalaag-1.08.zip";
    hash = "sha256-EHaOvZhoqzV1Q8CMA+R2abqFwnJSfPKV6CdN+4rP/kw=";
  }; in {
  name = "hoval";
  runtimeInputs = [ winePackages.minimal samba ];
  text = ''
    dir="''${XDG_DATA_HOME-~/.local/share}/hovalaag"
    mkdir -p "$dir/docs"
    ln -sf ${src}/{docs.html,sample.vasm,vliw_operation.png} "$dir/docs"
    cd "$dir"
    WINEDEBUG="fixme-all,$WINEDEBUG" WINEPREFIX="$dir/wineroot" \
      wine "${src}/hoval.exe" "$@"
  '';
  meta.platforms = [ "x86_64-linux" ];
})
# TODO: RE the binary or traffic to https://silverspaceship.com/leaderboard_server
# which seems to be down and stand up a compatible server, try WINEDEBUG=+relay
