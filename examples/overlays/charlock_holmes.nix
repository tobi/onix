# charlock_holmes — needs ICU, zlib, which, pkg-config
# ICU 76+ requires C++17; older gem versions (0.7.7) force C++11 which breaks.
{ pkgs, ruby, ... }:
{
  deps = with pkgs; [
    icu
    zlib
    pkg-config
    which
  ];
  beforeBuild = ''
    # Remove -std=c++11 from extconf.rb (old versions) so ICU 76 C++17 headers work
    find ext -name extconf.rb -exec sed -i 's/-std=c++11/-std=c++17/g' {} +
  '';
}
