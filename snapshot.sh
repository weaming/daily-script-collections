#!/bin/bash
# File Name : snapshot.sh
# Author    : weaming
# Mail      : garden.yuen@gmail.com
# Created   : 2018-09-08 14:25:51

SOURCE_REPO_PATH=~/src/Personal/dotfiles

paths="zsh/"

for p in $paths; do
    if [ ! -d "$p" ]; then
        dir=$(dirname $p)
        mkdir -p $dir
    fi
    source_dir=$SOURCE_REPO_PATH/$p
    echo copy $source_dir $p && \
        cp -r $source_dir ./$p
done

