{ pkgs, config, lib, ... }: {
  home.packages = with pkgs; [
    mpc rmpc mmtc # music-player
    sox
    mediainfo
    yt-dlp ytmdl spotdl
    # cava
  ] ++ lib.optionals stdenv.isLinux [
    kid3 strawberry ymuse
    media-downloader
  ];

  services = {
    mpd = { enable = true;
      musicDirectory = lib.mkDefault "${config.xdg.userDirs.music}/library";
      playlistDirectory = lib.mkDefault "${config.xdg.userDirs.music}/library/0-playlists";
      extraConfig = ''
        auto_update     "yes"
        replaygain      "album"
        metadata_to_use "artist,album,title,track,name,genre,date,composer,performer"
      '' + (lib.optionalString pkgs.stdenv.isLinux ''
        audio_output {
            type "pipewire"
            name "Pipewire Sound Server"
        }'');
    };
    mpd-mpris.enable = pkgs.stdenv.isLinux;
    mpd-discord-rpc.enable = pkgs.stdenv.isLinux;
  };
}
