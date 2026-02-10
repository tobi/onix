# gda — Ruby bindings for libgda (GNOME Data Access)
# Needs explicit PKG_CONFIG_PATH because libgda's .pc requires gobject-2.0, gthread-2.0, libxml-2.0
{ pkgs, ruby }: {
  deps = with pkgs; [ libgda5 pkg-config glib libxml2 ];
  beforeBuild = ''
    export PKG_CONFIG_PATH="${pkgs.libgda5}/lib/pkgconfig:${pkgs.glib.dev}/lib/pkgconfig:${pkgs.libxml2.dev}/lib/pkgconfig''${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
  '';
}
