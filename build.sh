#!/bin/bash

set -e

cd eat

T=/tmp/$USER/rust/targets/`pwd`/target

if [[ -L target ]] ; then
    if [[ "$(readlink target)" == "$T" ]] ; then
	mkdir -p $T
    fi
fi

# Otherwise
rm -rf target
mkdir -p $T
ln -s $T target

cargo build --release
mv target/release/eat ~/.local/bin
rm -rf ${T}
