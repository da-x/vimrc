#!/bin/bash

# Here's a nice way to avoid commits to .gitignore for submodules.

G=$(git rev-parse --git-dir)

echo tags >> ${G}/modules/external/vim-textobj-dash/info/exclude
echo tags >> ${G}/modules/external/vim-textobj-user/info/exclude
echo tags >> ${G}/modules/external/vim-textobj-underscore/info/exclude
