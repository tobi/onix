# datadog uses libdatadog gem's pkg-config at build time — not a system lib
{ pkgs, ruby, buildGem, ... }: {
  buildGems = [
    (buildGem "libdatadog")
  ];
}
