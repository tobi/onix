# google-protobuf — old versions (3.x) fail with -Werror=format-security
# Disable that warning-as-error
{ pkgs, ruby, ... }:
{
  deps = [ ];
  preBuild = ''
    export CFLAGS="$CFLAGS -Wno-error=format-security"
    export NIX_CFLAGS_COMPILE="''${NIX_CFLAGS_COMPILE:-} -Wno-error=format-security"
  '';
}
