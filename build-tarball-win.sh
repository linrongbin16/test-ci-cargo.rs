#!/bin/bash

set -x
set -eEuo pipefail

target="${INPUT_TARGET}"
bin="${INPUT_BIN}"
checksum=${INPUT_CHECKSUM}
archive="$bin-$target"

rustup target add $target
cargo build --release --bin $bin --target $target

mkdir -p bin
cp "target/$target/release/$bin.exe" bin
tar acf "${PWD}/${archive}.tar.gz" bin README.md LICENSE
7z a "${PWD}/${archive.zip}" bin README.md LICENSE
shasum -a $checksum "${archive}.tar.gz" >"${archive}.tar.gz.sha$checksum"
shasum -a $checksum "${archive}.zip" >"${archive}.zip.sha$checksum"