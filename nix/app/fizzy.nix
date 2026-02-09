#
# ╔══════════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate-gemset to refresh  ║
# ╚══════════════════════════════════════════════════════════════════╝
#
# FIZZY — 161 gems
# Generated from Gemfile.lock
#
{ pkgs, ruby }:

let
  inherit (pkgs) lib stdenv;
  gem = name: args: pkgs.callPackage (../gem + "/${name}") ({ inherit lib stdenv ruby; } // args);
in
{
  "action_text-trix" = gem "action_text-trix" { version = "2.1.16"; };
  "addressable" = gem "addressable" { version = "2.8.7"; };
  "ast" = gem "ast" { version = "2.4.3"; };
  "autotuner" = gem "autotuner" { version = "1.1.0"; };
  "aws-eventstream" = gem "aws-eventstream" { version = "1.4.0"; };
  "aws-partitions" = gem "aws-partitions" { version = "1.1203.0"; };
  "aws-sdk-core" = gem "aws-sdk-core" { version = "3.241.3"; };
  "aws-sdk-kms" = gem "aws-sdk-kms" { version = "1.120.0"; };
  "aws-sdk-s3" = gem "aws-sdk-s3" { version = "1.211.0"; };
  "aws-sigv4" = gem "aws-sigv4" { version = "1.12.1"; };
  "base64" = gem "base64" { version = "0.3.0"; };
  "bcrypt" = gem "bcrypt" { version = "3.1.21"; };
  "bcrypt_pbkdf" = gem "bcrypt_pbkdf" { version = "1.1.2"; };
  "benchmark" = gem "benchmark" { version = "0.5.0"; };
  "bigdecimal" = gem "bigdecimal" { version = "4.0.1"; };
  "bindex" = gem "bindex" { version = "0.8.1"; };
  "bootsnap" = gem "bootsnap" { version = "1.21.1"; };
  "brakeman" = gem "brakeman" { version = "7.1.2"; };
  "builder" = gem "builder" { version = "3.3.0"; };
  "bundler-audit" = gem "bundler-audit" { version = "0.9.3"; };
  "capybara" = gem "capybara" { version = "3.40.0"; };
  "childprocess" = gem "childprocess" { version = "5.1.0"; };
  "chunky_png" = gem "chunky_png" { version = "1.4.0"; };
  "concurrent-ruby" = gem "concurrent-ruby" { version = "1.3.6"; };
  "connection_pool" = gem "connection_pool" { version = "3.0.2"; };
  "crack" = gem "crack" { version = "1.0.1"; };
  "crass" = gem "crass" { version = "1.0.6"; };
  "date" = gem "date" { version = "3.5.1"; };
  "debug" = gem "debug" { version = "1.11.1"; };
  "dotenv" = gem "dotenv" { version = "3.2.0"; };
  "drb" = gem "drb" { version = "2.2.3"; };
  "ed25519" = gem "ed25519" { version = "1.4.0"; };
  "erb" = gem "erb" { version = "6.0.1"; };
  "erubi" = gem "erubi" { version = "1.13.1"; };
  "et-orbi" = gem "et-orbi" { version = "1.4.0"; };
  "faker" = gem "faker" { version = "3.5.3"; };
  "ffi" = gem "ffi" {
    version = "1.17.2";
    pkgs = pkgs;
  };
  "fugit" = gem "fugit" { version = "1.12.1"; };
  "geared_pagination" = gem "geared_pagination" { version = "1.2.0"; };
  "globalid" = gem "globalid" { version = "1.3.0"; };
  "hashdiff" = gem "hashdiff" { version = "1.2.1"; };
  "i18n" = gem "i18n" { version = "1.14.8"; };
  "image_processing" = gem "image_processing" { version = "1.14.0"; };
  "importmap-rails" = gem "importmap-rails" { version = "2.2.2"; };
  "io-console" = gem "io-console" { version = "0.8.2"; };
  "irb" = gem "irb" { version = "1.16.0"; };
  "jbuilder" = gem "jbuilder" { version = "2.14.1"; };
  "jmespath" = gem "jmespath" { version = "1.6.2"; };
  "json" = gem "json" { version = "2.18.0"; };
  "jwt" = gem "jwt" { version = "3.1.2"; };
  "kamal" = gem "kamal" { version = "2.10.1"; };
  "language_server-protocol" = gem "language_server-protocol" { version = "3.17.0.5"; };
  "launchy" = gem "launchy" { version = "3.1.1"; };
  "letter_opener" = gem "letter_opener" { version = "1.10.0"; };
  "lint_roller" = gem "lint_roller" { version = "1.1.0"; };
  "logger" = gem "logger" { version = "1.7.0"; };
  "loofah" = gem "loofah" { version = "2.25.0"; };
  "mail" = gem "mail" { version = "2.9.0"; };
  "marcel" = gem "marcel" { version = "1.1.0"; };
  "matrix" = gem "matrix" { version = "0.4.3"; };
  "mini_magick" = gem "mini_magick" { version = "5.3.1"; };
  "mini_mime" = gem "mini_mime" { version = "1.1.5"; };
  "minitest" = gem "minitest" { version = "6.0.1"; };
  "mission_control-jobs" = gem "mission_control-jobs" { version = "1.1.0"; };
  "mittens" = gem "mittens" {
    version = "0.3.1";
    pkgs = pkgs;
  };
  "mocha" = gem "mocha" { version = "3.0.1"; };
  "msgpack" = gem "msgpack" { version = "1.8.0"; };
  "net-http-persistent" = gem "net-http-persistent" { version = "4.0.8"; };
  "net-imap" = gem "net-imap" { version = "0.6.2"; };
  "net-pop" = gem "net-pop" { version = "0.1.2"; };
  "net-protocol" = gem "net-protocol" { version = "0.2.2"; };
  "net-scp" = gem "net-scp" { version = "4.1.0"; };
  "net-sftp" = gem "net-sftp" { version = "4.0.0"; };
  "net-smtp" = gem "net-smtp" { version = "0.5.1"; };
  "net-ssh" = gem "net-ssh" { version = "7.3.0"; };
  "nio4r" = gem "nio4r" { version = "2.7.5"; };
  "nokogiri" = gem "nokogiri" {
    version = "1.19.0";
    pkgs = pkgs;
  };
  "openssl" = gem "openssl" {
    version = "4.0.0";
    pkgs = pkgs;
  };
  "ostruct" = gem "ostruct" { version = "0.6.3"; };
  "parallel" = gem "parallel" { version = "1.27.0"; };
  "parser" = gem "parser" { version = "3.3.10.0"; };
  "platform_agent" = gem "platform_agent" { version = "1.0.1"; };
  "pp" = gem "pp" { version = "0.6.3"; };
  "prettyprint" = gem "prettyprint" { version = "0.2.0"; };
  "prism" = gem "prism" { version = "1.8.0"; };
  "propshaft" = gem "propshaft" { version = "1.3.1"; };
  "psych" = gem "psych" {
    version = "5.3.1";
    pkgs = pkgs;
  };
  "public_suffix" = gem "public_suffix" { version = "6.0.2"; };
  "puma" = gem "puma" {
    version = "7.1.0";
    pkgs = pkgs;
  };
  "raabro" = gem "raabro" { version = "1.4.0"; };
  "racc" = gem "racc" { version = "1.8.1"; };
  "rack" = gem "rack" { version = "3.2.4"; };
  "rack-mini-profiler" = gem "rack-mini-profiler" { version = "4.0.1"; };
  "rack-session" = gem "rack-session" { version = "2.1.1"; };
  "rack-test" = gem "rack-test" { version = "2.2.0"; };
  "rackup" = gem "rackup" { version = "2.3.1"; };
  "rails-dom-testing" = gem "rails-dom-testing" { version = "2.3.0"; };
  "rails-html-sanitizer" = gem "rails-html-sanitizer" { version = "1.6.2"; };
  "rainbow" = gem "rainbow" { version = "3.1.1"; };
  "rake" = gem "rake" { version = "13.3.1"; };
  "rdoc" = gem "rdoc" { version = "7.0.3"; };
  "redcarpet" = gem "redcarpet" { version = "3.6.1"; };
  "regexp_parser" = gem "regexp_parser" { version = "2.11.3"; };
  "reline" = gem "reline" { version = "0.6.3"; };
  "rexml" = gem "rexml" { version = "3.4.4"; };
  "rouge" = gem "rouge" { version = "4.7.0"; };
  "rqrcode" = gem "rqrcode" { version = "3.2.0"; };
  "rqrcode_core" = gem "rqrcode_core" { version = "2.1.0"; };
  "rubocop" = gem "rubocop" { version = "1.81.7"; };
  "rubocop-ast" = gem "rubocop-ast" { version = "1.48.0"; };
  "rubocop-performance" = gem "rubocop-performance" { version = "1.26.1"; };
  "rubocop-rails" = gem "rubocop-rails" { version = "2.34.0"; };
  "rubocop-rails-omakase" = gem "rubocop-rails-omakase" { version = "1.1.0"; };
  "ruby-progressbar" = gem "ruby-progressbar" { version = "1.13.0"; };
  "ruby-vips" = gem "ruby-vips" { version = "2.2.5"; };
  "ruby2_keywords" = gem "ruby2_keywords" { version = "0.0.5"; };
  "rubyzip" = gem "rubyzip" { version = "3.2.2"; };
  "securerandom" = gem "securerandom" { version = "0.4.1"; };
  "selenium-webdriver" = gem "selenium-webdriver" { version = "4.39.0"; };
  "solid_cable" = gem "solid_cable" { version = "3.0.12"; };
  "solid_cache" = gem "solid_cache" { version = "1.0.10"; };
  "solid_queue" = gem "solid_queue" { version = "1.2.4"; };
  "sqlite3" = gem "sqlite3" {
    version = "2.8.0";
    pkgs = pkgs;
  };
  "sshkit" = gem "sshkit" { version = "1.25.0"; };
  "stimulus-rails" = gem "stimulus-rails" { version = "1.3.4"; };
  "stringio" = gem "stringio" { version = "3.2.0"; };
  "thor" = gem "thor" { version = "1.5.0"; };
  "thruster" = gem "thruster" { version = "0.1.17"; };
  "timeout" = gem "timeout" { version = "0.6.0"; };
  "trilogy" = gem "trilogy" {
    version = "2.9.0";
    pkgs = pkgs;
  };
  "tsort" = gem "tsort" { version = "0.2.0"; };
  "turbo-rails" = gem "turbo-rails" { version = "2.0.21"; };
  "tzinfo" = gem "tzinfo" { version = "2.0.6"; };
  "unicode-display_width" = gem "unicode-display_width" { version = "3.2.0"; };
  "unicode-emoji" = gem "unicode-emoji" { version = "4.1.0"; };
  "uri" = gem "uri" { version = "1.1.1"; };
  "vcr" = gem "vcr" { version = "6.4.0"; };
  "web-console" = gem "web-console" { version = "4.2.1"; };
  "web-push" = gem "web-push" { version = "3.1.0"; };
  "webmock" = gem "webmock" { version = "3.26.1"; };
  "websocket" = gem "websocket" { version = "1.2.11"; };
  "websocket-driver" = gem "websocket-driver" { version = "0.8.0"; };
  "websocket-extensions" = gem "websocket-extensions" { version = "0.1.5"; };
  "xpath" = gem "xpath" { version = "3.2.0"; };
  "zeitwerk" = gem "zeitwerk" { version = "2.7.4"; };
  "zip_kit" = gem "zip_kit" { version = "6.3.4"; };

  # git: rails @ 60d92e4e7dfe
  "rails-60d92e4e7dfe" = gem "rails" { git.rev = "60d92e4e7dfe"; };

  # git: lexxy @ 4f0fc4d5773b
  "lexxy-4f0fc4d5773b" = gem "lexxy" { git.rev = "4f0fc4d5773b"; };

  # git: useragent @ 433ca320a42d
  "useragent-433ca320a42d" = gem "useragent" { git.rev = "433ca320a42d"; };
}
