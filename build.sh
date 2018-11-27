#!/bin/bash

set -e

cd rex
cargo build --release
mv target/release/rex ../bin
rm -rf target
