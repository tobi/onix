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
  call = path: pkgs.callPackage path { inherit ruby; };
  callP = path: pkgs.callPackage path { inherit ruby pkgs; };
in {
  "action_text-trix" = call ./action_text-trix/2.1.16;
  "addressable" = call ./addressable/2.8.7;
  "ast" = call ./ast/2.4.3;
  "autotuner" = call ./autotuner/1.1.0;
  "aws-eventstream" = call ./aws-eventstream/1.4.0;
  "aws-partitions" = call ./aws-partitions/1.1203.0;
  "aws-sdk-core" = call ./aws-sdk-core/3.241.3;
  "aws-sdk-kms" = call ./aws-sdk-kms/1.120.0;
  "aws-sdk-s3" = call ./aws-sdk-s3/1.211.0;
  "aws-sigv4" = call ./aws-sigv4/1.12.1;
  "base64" = call ./base64/0.3.0;
  "bcrypt" = call ./bcrypt/3.1.21;
  "bcrypt_pbkdf" = call ./bcrypt_pbkdf/1.1.2;
  "benchmark" = call ./benchmark/0.5.0;
  "bigdecimal" = call ./bigdecimal/4.0.1;
  "bindex" = call ./bindex/0.8.1;
  "bootsnap" = call ./bootsnap/1.21.1;
  "brakeman" = call ./brakeman/7.1.2;
  "builder" = call ./builder/3.3.0;
  "bundler-audit" = call ./bundler-audit/0.9.3;
  "capybara" = call ./capybara/3.40.0;
  "childprocess" = call ./childprocess/5.1.0;
  "chunky_png" = call ./chunky_png/1.4.0;
  "concurrent-ruby" = call ./concurrent-ruby/1.3.6;
  "connection_pool" = call ./connection_pool/3.0.2;
  "crack" = call ./crack/1.0.1;
  "crass" = call ./crass/1.0.6;
  "date" = call ./date/3.5.1;
  "debug" = call ./debug/1.11.1;
  "dotenv" = call ./dotenv/3.2.0;
  "drb" = call ./drb/2.2.3;
  "ed25519" = call ./ed25519/1.4.0;
  "erb" = call ./erb/6.0.1;
  "erubi" = call ./erubi/1.13.1;
  "et-orbi" = call ./et-orbi/1.4.0;
  "faker" = call ./faker/3.5.3;
  "ffi" = callP ./ffi/1.17.2;
  "fugit" = call ./fugit/1.12.1;
  "geared_pagination" = call ./geared_pagination/1.2.0;
  "globalid" = call ./globalid/1.3.0;
  "hashdiff" = call ./hashdiff/1.2.1;
  "i18n" = call ./i18n/1.14.8;
  "image_processing" = call ./image_processing/1.14.0;
  "importmap-rails" = call ./importmap-rails/2.2.2;
  "io-console" = call ./io-console/0.8.2;
  "irb" = call ./irb/1.16.0;
  "jbuilder" = call ./jbuilder/2.14.1;
  "jmespath" = call ./jmespath/1.6.2;
  "json" = call ./json/2.18.0;
  "jwt" = call ./jwt/3.1.2;
  "kamal" = call ./kamal/2.10.1;
  "language_server-protocol" = call ./language_server-protocol/3.17.0.5;
  "launchy" = call ./launchy/3.1.1;
  "letter_opener" = call ./letter_opener/1.10.0;
  "lint_roller" = call ./lint_roller/1.1.0;
  "logger" = call ./logger/1.7.0;
  "loofah" = call ./loofah/2.25.0;
  "mail" = call ./mail/2.9.0;
  "marcel" = call ./marcel/1.1.0;
  "matrix" = call ./matrix/0.4.3;
  "mini_magick" = call ./mini_magick/5.3.1;
  "mini_mime" = call ./mini_mime/1.1.5;
  "minitest" = call ./minitest/6.0.1;
  "mission_control-jobs" = call ./mission_control-jobs/1.1.0;
  "mittens" = callP ./mittens/0.3.1;
  "mocha" = call ./mocha/3.0.1;
  "msgpack" = call ./msgpack/1.8.0;
  "net-http-persistent" = call ./net-http-persistent/4.0.8;
  "net-imap" = call ./net-imap/0.6.2;
  "net-pop" = call ./net-pop/0.1.2;
  "net-protocol" = call ./net-protocol/0.2.2;
  "net-scp" = call ./net-scp/4.1.0;
  "net-sftp" = call ./net-sftp/4.0.0;
  "net-smtp" = call ./net-smtp/0.5.1;
  "net-ssh" = call ./net-ssh/7.3.0;
  "nio4r" = call ./nio4r/2.7.5;
  "nokogiri" = callP ./nokogiri/1.19.0;
  "openssl" = callP ./openssl/4.0.0;
  "ostruct" = call ./ostruct/0.6.3;
  "parallel" = call ./parallel/1.27.0;
  "parser" = call ./parser/3.3.10.0;
  "platform_agent" = call ./platform_agent/1.0.1;
  "pp" = call ./pp/0.6.3;
  "prettyprint" = call ./prettyprint/0.2.0;
  "prism" = call ./prism/1.8.0;
  "propshaft" = call ./propshaft/1.3.1;
  "psych" = callP ./psych/5.3.1;
  "public_suffix" = call ./public_suffix/6.0.2;
  "puma" = callP ./puma/7.1.0;
  "raabro" = call ./raabro/1.4.0;
  "racc" = call ./racc/1.8.1;
  "rack" = call ./rack/3.2.4;
  "rack-mini-profiler" = call ./rack-mini-profiler/4.0.1;
  "rack-session" = call ./rack-session/2.1.1;
  "rack-test" = call ./rack-test/2.2.0;
  "rackup" = call ./rackup/2.3.1;
  "rails-dom-testing" = call ./rails-dom-testing/2.3.0;
  "rails-html-sanitizer" = call ./rails-html-sanitizer/1.6.2;
  "rainbow" = call ./rainbow/3.1.1;
  "rake" = call ./rake/13.3.1;
  "rdoc" = call ./rdoc/7.0.3;
  "redcarpet" = call ./redcarpet/3.6.1;
  "regexp_parser" = call ./regexp_parser/2.11.3;
  "reline" = call ./reline/0.6.3;
  "rexml" = call ./rexml/3.4.4;
  "rouge" = call ./rouge/4.7.0;
  "rqrcode" = call ./rqrcode/3.2.0;
  "rqrcode_core" = call ./rqrcode_core/2.1.0;
  "rubocop" = call ./rubocop/1.81.7;
  "rubocop-ast" = call ./rubocop-ast/1.48.0;
  "rubocop-performance" = call ./rubocop-performance/1.26.1;
  "rubocop-rails" = call ./rubocop-rails/2.34.0;
  "rubocop-rails-omakase" = call ./rubocop-rails-omakase/1.1.0;
  "ruby-progressbar" = call ./ruby-progressbar/1.13.0;
  "ruby-vips" = call ./ruby-vips/2.2.5;
  "ruby2_keywords" = call ./ruby2_keywords/0.0.5;
  "rubyzip" = call ./rubyzip/3.2.2;
  "securerandom" = call ./securerandom/0.4.1;
  "selenium-webdriver" = call ./selenium-webdriver/4.39.0;
  "solid_cable" = call ./solid_cable/3.0.12;
  "solid_cache" = call ./solid_cache/1.0.10;
  "solid_queue" = call ./solid_queue/1.2.4;
  "sqlite3" = callP ./sqlite3/2.8.0;
  "sshkit" = call ./sshkit/1.25.0;
  "stimulus-rails" = call ./stimulus-rails/1.3.4;
  "stringio" = call ./stringio/3.2.0;
  "thor" = call ./thor/1.5.0;
  "thruster" = call ./thruster/0.1.17;
  "timeout" = call ./timeout/0.6.0;
  "trilogy" = callP ./trilogy/2.9.0;
  "tsort" = call ./tsort/0.2.0;
  "turbo-rails" = call ./turbo-rails/2.0.21;
  "tzinfo" = call ./tzinfo/2.0.6;
  "unicode-display_width" = call ./unicode-display_width/3.2.0;
  "unicode-emoji" = call ./unicode-emoji/4.1.0;
  "uri" = call ./uri/1.1.1;
  "vcr" = call ./vcr/6.4.0;
  "web-console" = call ./web-console/4.2.1;
  "web-push" = call ./web-push/3.1.0;
  "webmock" = call ./webmock/3.26.1;
  "websocket" = call ./websocket/1.2.11;
  "websocket-driver" = call ./websocket-driver/0.8.0;
  "websocket-extensions" = call ./websocket-extensions/0.1.5;
  "xpath" = call ./xpath/3.2.0;
  "zeitwerk" = call ./zeitwerk/2.7.4;
  "zip_kit" = call ./zip_kit/6.3.4;

  # git: rails @ 60d92e4e7dfe
  "rails-60d92e4e7dfe" = call ./git/rails-60d92e4e7dfe;

  # git: lexxy @ 4f0fc4d5773b
  "lexxy-4f0fc4d5773b" = call ./git/lexxy-4f0fc4d5773b;

  # git: useragent @ 433ca320a42d
  "useragent-433ca320a42d" = call ./git/useragent-433ca320a42d;
}
