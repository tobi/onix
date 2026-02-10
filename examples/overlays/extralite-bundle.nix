# extralite-bundle: fast SQLite3 bindings (bundled variant)
#
# Despite the "-bundle" name, the gem's extconf.rb checks ENV['EXTRALITE_BUNDLE']
# to decide whether to use bundled SQLite. Without it set, it uses system sqlite
# via pkg-config — which is what we want.
#
# The extconf.rb path (without EXTRALITE_BUNDLE):
#   require 'mkmf'
#   pkg_config('sqlite3')  # finds system sqlite via pkg-config
#   create_makefile('extralite/extralite')
#
{ pkgs, ruby, ... }:
{
  deps = with pkgs; [
    sqlite
    pkg-config
  ];
}
