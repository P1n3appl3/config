{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    mpc-cli
    rmpc mmtc # music-player

    sox
    mediainfo

    yt-dlp ytmdl spotdl
    media-downloader

    picard kid3 puddletag # onetagger tageditor

    strawberry
  ];

  services = {
    mpd = { enable = true;
      musicDirectory = "${config.xdg.userDirs.music}/library";
      extraConfig = ''
        auto_update     "yes"
        replaygain      "album"
        metadata_to_use "artist,album,title,track,name,genre,date,composer,performer"
        audio_output {
            type "pipewire"
            name "Pipewire Sound Server"
        }'';
    };
    mpd-mpris.enable = true;
    # mpd-discord-rpc.enable = true; # TODO: debug spinning a core (looking for discord?)
  };
}
