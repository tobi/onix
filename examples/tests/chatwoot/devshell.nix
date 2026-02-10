{ pkgs ? import <nixpkgs> {}, ruby ? pkgs.ruby_3_4 }:
let
  resolve = import ../../nix/modules/resolve.nix;
  gems = resolve { inherit pkgs ruby; config = { deps.gem.app.chatwoot.enable = true; }; };
in gems.devShell {
  name = "chatwoot-devshell";
  buildInputs = with pkgs; [
    (postgresql.withPackages (ps: [ ps.pgvector ]))
    redis nodejs_22 yarn
    vips imagemagick libyaml openssl zlib pkg-config libffi git
  ];
  shellHook = ''
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ pkgs.vips pkgs.imagemagick pkgs.libffi ]}''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

    export PGDATA="$TMPDIR/pg"
    export PGHOST="$TMPDIR/pg"
    export PGPORT="5433"
    export REDIS_URL="redis://localhost:6380"

    if [ ! -d "$PGDATA" ]; then
      initdb --no-locale -D "$PGDATA" -U postgres >/dev/null 2>&1
      echo "unix_socket_directories = '$PGDATA'" >> "$PGDATA/postgresql.conf"
      echo "port = $PGPORT" >> "$PGDATA/postgresql.conf"
    fi
    pg_ctl -D "$PGDATA" -l "$TMPDIR/pg.log" -o "-k $PGDATA" -w start >/dev/null 2>&1 || true
    redis-server --daemonize yes --port 6380 --dir "$TMPDIR" --logfile "$TMPDIR/redis.log" >/dev/null 2>&1 || true

    export POSTGRES_HOST="$PGDATA"
    export POSTGRES_PORT="$PGPORT"
    export POSTGRES_USERNAME="postgres"
    export POSTGRES_PASSWORD=""
    export RAILS_ENV="test"
    export SECRET_KEY_BASE="test-secret-key-base-for-nix-shell"
    export FRONTEND_URL="http://localhost:3000"

    rm -rf tmp/cache/bootsnap 2>/dev/null
  '';
}
