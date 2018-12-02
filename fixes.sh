#!/bin/bash

# Here's a nice way to avoid commits to .gitignore for submodules.

G=$(git rev-parse --git-dir)

echo tags >> vim-plugged/tlib/.git/info/exclude
echo tags >> vim-plugged/echodoc.vim/.git/info/exclude
echo tags >> vim-plugged/rust-doc.vim/.git/info/exclude
echo tags >> vim-plugged/conflict-marker.vim/.git/info/exclude
echo tags >> vim-plugged/vim-expand-region/.git/info/exclude
