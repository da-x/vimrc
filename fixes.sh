#!/bin/bash

# Here's a nice way to avoid commits to .gitignore for submodules.

echo tags >> ./.git/modules/external/vim-textobj-dash/info/exclude
echo tags >> ./.git/modules/external/vim-textobj-user/info/exclude
echo tags >> ./.git/modules/external/vim-textobj-underscore/info/exclude
