#!/bin/sh
set -eu

ROOT=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
PROJECT=${1:-}
shift || true
JAVA=${JAVA:-java}
SHIMELINUX_JAR=${SHIMELINUX_JAR:-/usr/share/java/shimelinux.jar}

case "$PROJECT" in
    evil-neuro-shim)
        SOURCE=$ROOT/evil_neuro_shim
        PROFILE=evil-neuro-shim
        ;;
    neuro-shim)
        SOURCE=$ROOT/neuro_shim
        PROFILE=neuro-shim
        ;;
    the-neuroling-collection)
        SOURCE=$ROOT/The-Neuroling-Collection
        PROFILE=the-neuroling-collection
        ;;
    *)
        printf '%s\n' "Usage: $0 evil-neuro-shim|neuro-shim|the-neuroling-collection" >&2
        exit 2
        ;;
esac

if ! command -v "$JAVA" >/dev/null 2>&1; then
    printf '%s\n' "Java 21 or newer was not found. Set JAVA to a Java 21+ executable." >&2
    exit 127
fi

if [ ! -f "$SHIMELINUX_JAR" ]; then
    printf '%s\n' "ShimeLinux was not found at $SHIMELINUX_JAR." >&2
    printf '%s\n' "Install it from https://github.com/BujjuIsABee/shimelinux or set SHIMELINUX_JAR." >&2
    exit 127
fi

version_output=$("$JAVA" -version 2>&1)
major_version=$(printf '%s\n' "$version_output" |
    sed -n '1s/.*"\([0-9][0-9]*\).*/\1/p')
case "$major_version" in
    ''|*[!0-9])
        printf '%s\n' "Could not determine the Java version from: $version_output" >&2
        exit 1
        ;;
esac
if [ "$major_version" -lt 21 ]; then
    printf '%s\n' "ShimeLinux requires Java 21 or newer; found Java $major_version." >&2
    exit 1
fi

DATA_HOME=${XDG_DATA_HOME:-"$HOME/.local/share"}
APP_HOME=$DATA_HOME/desktop-pets/shimelinux/$PROFILE/home
CONFIG_DIR=$APP_HOME/.config/shimelinux
MARKER=$CONFIG_DIR/.desktop-pets-imported

if [ ! -f "$MARKER" ]; then
    if [ -d "$CONFIG_DIR" ] &&
        [ -n "$(find "$CONFIG_DIR" -mindepth 1 -maxdepth 1 -print -quit)" ]; then
        printf '%s\n' "Refusing to overwrite an existing ShimeLinux profile without an import marker: $CONFIG_DIR" >&2
        exit 1
    fi
    mkdir -p "$CONFIG_DIR"
    cp -a "$SOURCE/conf" "$CONFIG_DIR/"
    cp -a "$SOURCE/img" "$CONFIG_DIR/"
    touch "$MARKER"
fi

exec "$JAVA" -Duser.home="$APP_HOME" -jar "$SHIMELINUX_JAR" "$@"
