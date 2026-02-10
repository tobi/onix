# rdkafka — uses RDKAFKA_EXT_PATH to link against system librdkafka
{ pkgs, ruby }: {
  deps = with pkgs; [ rdkafka ];
  beforeBuild = ''
    export RDKAFKA_EXT_PATH="${pkgs.rdkafka}"
  '';
}
