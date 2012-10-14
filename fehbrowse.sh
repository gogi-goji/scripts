#!/bin/bash

# Taken from bitcero at http://bbs.archlinux.org/viewtopic.php?id=112509
# Also see https://wiki.archlinux.org/index.php?title=Feh

shopt -s nullglob

if [[ ! -f $1 ]]; then
    echo "$0: first argument is not a file" >&2
    exit 1
fi

file=$(basename -- "$1")
dir=$(dirname -- "$1")
arr=()
shift

cd -- "$dir"

frmt="*.jpg *.jpeg *.png *.bmp *.gif *.xcf *.svg *.ico *.tif *.tiff "
frmtall=${frmt}${frmt^^}

for i in $frmtall; do
    [[ -f $i ]] || continue
    arr+=("$i")
    [[ $i == $file ]] && c=$((${#arr[@]} - 1))
done

exec feh "$@" -- "${arr[@]:c}" "${arr[@]:0:c}"

