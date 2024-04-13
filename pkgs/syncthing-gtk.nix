{ pkgs, lib, stdenvNoCC, meson, ninja,
  python3, libnotify, librsvg, killall, gtk3, libappindicator-gtk3,
  substituteAll, syncthing, wrapGAppsHook, gnome, gobject-introspection,
  gsettings-desktop-schemas , pango, gdk-pixbuf, atk }:

stdenvNoCC.mkDerivation rec {
  version = "unstable-2023-07-28";
  pname = "syncthing-gtk";

  src = pkgs.fetchFromGitHub {
    owner = "syncthing-gtk";
    repo = "syncthing-gtk";
    rev = "3358e2d86af6f11b1f03ee9cd00bfc1abea2d214";
    sha256 = "17rv80csk9444fwvn8mjcdr1ibj9b6bka30vgx2crdm41i88r2ac";
  };
  meta.platforms = lib.platforms.linux;
  meta.broken = true;

  configurePhase = ''
    mkdir _build
    meson setup _build --prefix=/
  '';

  buildPhase = ''
    cd _build
    ninja
  '';

  installPhase = ''
    DESTDIR=$out ninja install
  '';

  nativeBuildInputs = [
    meson ninja
    wrapGAppsHook
    # For setup hook populating GI_TYPELIB_PATH
    gobject-introspection
    pango gdk-pixbuf atk libnotify
  ];

  buildInputs = [
    gtk3 librsvg libappindicator-gtk3
    libnotify gnome.adwaita-icon-theme
    # Schemas with proxy configuration
    gsettings-desktop-schemas
  ];

  propagatedBuildInputs = [
    (python3.withPackages (ps: with ps; [ python-dateutil pyinotify pygobject3 bcrypt ]))
  ];

  # patches = [
  #   (substituteAll {
  #     src = ./paths.patch;
  #     killall = "${killall}/bin/killall";
  #     syncthing = "${syncthing}/bin/syncthing";
  #   })
  # ];

  # postPatch = ''
  #   substituteInPlace setup.py --replace "version = get_version()" "version = '${version}'"
  #   substituteInPlace scripts/syncthing-gtk --replace "/usr/share" "$out/share"
  #   substituteInPlace syncthing_gtk/app.py --replace "/usr/share" "$out/share"
  #   substituteInPlace syncthing_gtk/uisettingsdialog.py --replace "/usr/share" "$out/share"
  #   substituteInPlace syncthing_gtk/wizard.py --replace "/usr/share" "$out/share"
  #   substituteInPlace syncthing-gtk.desktop --replace "/usr/bin/syncthing-gtk" "$out/bin/syncthing-gtk"
  # '';
}
