#!/bin/bash

exec nvim -c 'PlugUpdate | PlugSnapshot! snapshot.vim'
