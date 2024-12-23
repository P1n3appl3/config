{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    mediainfo
    sox
    mpc-cli
    music-player
    strawberry
    picard tageditor
    ytmdl spotdl
  ];

  programs = {
    beets = { enable = true;
      package = pkgs.beets-unstable;
      mpdIntegration = { enableStats = true; enableUpdate = true; };
      settings = {
        directory = config.xdg.userDirs.music;
        plugins = [ "badfiles" "chroma" "convert" "deezer" "duplicates" "edit"
          "embedart" "fetchart" "fromfilename" "fuzzy" "info" "keyfinder" "lyrics"
          "mbsync" "missing" "mpdstats" "mpdupdate" "replaygain" "scrub" "spotify"
        ];
        art_filename = "albumart";
        fetchart = { max_width = 1080; sources = "*"; };
        import.move = true;
        keyfinder = { auto = true; bin = "${pkgs.keyfinder-cli}/bin/keyfinder-cli"; };
        lyrics.auto = true;
        replaygain = { auto = true; backend = "ffmpeg"; };
      };
    };
    ncmpcpp = { enable = true;
      settings = {
        mouse_list_scroll_whole_page = "yes";
        lines_scrolled = "1";
        message_delay_time = "2";
        playlist_shorten_total_times = "yes";
        playlist_display_mode = "columns";
        autocenter_mode = "yes";
        centered_cursor = "yes";
        display_bitrate = "yes";
        user_interface = "classic";
        titles_visibility = "no";
        allow_for_physical_item_deletion = "yes";

        progressbar_elapsed_color = "white";
        progressbar_color = "black";
        statusbar_color = "white";
        progressbar_look = "━━─";

        now_playing_prefix = "$b";
        now_playing_suffix = "$8$/b";

        song_columns_list_format = "(6)[blue]{l} (20)[yellow]{a} (34)[blue]{t|f}";
        song_status_format = "$4%a $8- $5%t";
        song_library_format = "{%n - }{%t}|{%f}";
      };
    };
  };

  services = {
    mpd = { enable = true;
      musicDirectory = "${config.xdg.userDirs.music}/library";
      extraConfig = ''
        auto_update "yes"
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
