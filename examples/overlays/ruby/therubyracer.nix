# therubyracer — Depends on libv8 (old, unbuildable versions).
# This gem is abandoned; use mini_racer instead.
# Skip the build entirely.
{ pkgs, ruby, ... }:
{
  deps = [ ];
  buildPhase = ''
    echo "therubyracer: skipping build (abandoned gem, use mini_racer instead)"
  '';
}
