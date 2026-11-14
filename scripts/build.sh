#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

version="$(tr -d '[:space:]' < element-version.txt)"
archive=".cache/element-v${version}.tar.gz"
url="https://github.com/element-hq/element-web/releases/download/v${version}/element-v${version}.tar.gz"

mkdir -p .cache
if [ ! -f "$archive" ]; then
    curl -fsSL "$url" -o "$archive"
fi

rm -rf public .extract
mkdir -p .extract
tar -xzf "$archive" -C .extract
mv ".extract/element-v${version}" public
rm -rf .extract

cp config.json public/config.json
find public -name '*.map' -delete
