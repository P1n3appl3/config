{ config, pkgs, ... }: {
  services = {
    snapper = {
      persistentTimer = true;
      configs.home = {
        SUBVOLUME = "/home";
        NUMBER_CLEANUP = true; TIMELINE_CLEANUP = true; TIMELINE_CREATE = true;
        ALLOW_USERS = [ "julia" ];
      };
    };
    borgbackup.jobs.home = let
      path = "/mnt/borg-snapper";
      name = config.networking.hostName;
    in {
      paths = [ path ]; readWritePaths = [ "/mnt" ];
      repo = "ssh://u662900@u662900.your-storagebox.de:23/home/backups/${name}";
      environment.BORG_RSH = "ssh -i /home/julia/.ssh/id_ed25519";
      environment.BORG_REMOTE_PATH = "borg-1.4";
      encryption.mode = "none";
      compression = "auto,zstd";
      startAt = "daily";
      prune.keep = { daily = 2; weekly = 2; monthly = 6; yearly = -1; };
      extraPruneArgs = [ "--stats" ];
      extraCreateArgs = [ "--stats" "--progress" ];
      preHook = ''
        mkdir -p ${path}
        LATEST=$(find /home/.snapshots -mindepth 2 -maxdepth 2 -type d -name "snapshot" | sort -V | tail -n 1)
        if [ -z "$LATEST" ]; then
          echo "No snapshots found in /home/.snapshots"
          exit 1
        fi
        echo backing up snapshot: $LATEST
        ${pkgs.util-linux.mount}/bin/mount --bind "$LATEST" ${path}
      ''; # TODO: look into using snapborg to do this more robustly
      postHook = "${pkgs.util-linux.mount}/bin/umount ${path} || true";
    };
  };
  programs.ssh.knownHosts."storagebox" = {
    hostNames = [ "[u662900.your-storagebox.de]:23" ];
    publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIICf9svRenC/PLKIL9nk6K/pxQgoiFC41wTNvoIncOxs";
  };
}
