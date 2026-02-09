# Chatwoot dev/test shell — PostgreSQL + Redis via local tmpdir services.
#
# Usage:
#   nix-shell tests/chatwoot/devshell.nix
#   # then: cd ~/src/ruby-tests/chatwoot && bundle exec rspec spec/models/...
{ pkgs ? import <nixpkgs> {}, ruby ? pkgs.ruby_3_4 }:

let
  bundlePath = import ../../out/chatwoot/bundle-path.nix { inherit pkgs ruby; };
  rubyApiVersion = "${builtins.toString ruby.version.major}.${builtins.toString ruby.version.minor}.0";
in pkgs.mkShell {
  buildInputs = [
    ruby
    pkgs.postgresql
    pkgs.redis
    pkgs.nodejs_22
    pkgs.yarn
    pkgs.vips
    pkgs.imagemagick
    pkgs.pkg-config
    pkgs.git
  ];

  BUNDLE_PATH = "${bundlePath}";
  BUNDLE_GEMFILE = builtins.toPath ~/src/ruby-tests/chatwoot/Gemfile;

  # PostgreSQL + Redis managed in a tmpdir
  shellHook = ''
    export GEM_PATH="${bundlePath}/ruby/${rubyApiVersion}:$(${ruby}/bin/ruby -e 'puts Gem.default_dir')"
    export PATH="${bundlePath}/ruby/${rubyApiVersion}/bin:$PATH"

    export PGDATA="$TMPDIR/pg"
    export PGHOST="$TMPDIR/pg"
    export PGPORT="5433"
    export REDIS_URL="redis://localhost:6380"

    # PostgreSQL
    if [ ! -d "$PGDATA" ]; then
      initdb --no-locale -D "$PGDATA" -U postgres >/dev/null 2>&1
      echo "unix_socket_directories = '$PGDATA'" >> "$PGDATA/postgresql.conf"
      echo "port = $PGPORT" >> "$PGDATA/postgresql.conf"
    fi
    pg_ctl -D "$PGDATA" -l "$TMPDIR/pg.log" -o "-k $PGDATA" start >/dev/null 2>&1 || true

    # Redis
    redis-server --daemonize yes --port 6380 --dir "$TMPDIR" --logfile "$TMPDIR/redis.log" >/dev/null 2>&1 || true

    # Chatwoot env
    export POSTGRES_HOST="$PGDATA"
    export POSTGRES_PORT="$PGPORT"
    export POSTGRES_USERNAME="postgres"
    export POSTGRES_PASSWORD=""
    export RAILS_ENV="test"
    export SECRET_KEY_BASE="test-secret-key-base-for-nix-shell"
    export FRONTEND_URL="http://localhost:3000"

    # LD_LIBRARY_PATH for FFI gems (libvips etc.)
    export LD_LIBRARY_PATH="${pkgs.libvips}/lib:${pkgs.imagemagick}/lib:''${LD_LIBRARY_PATH:-}"

    echo "Chatwoot devshell ready (Ruby ${ruby.version}, PostgreSQL on :$PGPORT, Redis on :6380)"
    echo "Bundle path: ${bundlePath}"
  '';
}
