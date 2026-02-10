# debase — Incompatible with Ruby 3.4 (uses deprecated Data_Get_Struct API).
# This gem is abandoned; use debug gem instead.
# Skip the build entirely.
{ pkgs, ruby }:
{
  deps = [ ];
  buildPhase = ''
    echo "debase: skipping build (incompatible with Ruby 3.4, use debug gem instead)"
  '';
}
