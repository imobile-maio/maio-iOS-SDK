#!/bin/bash

echo "Start Maio.framework pdate script."

readonly root=$(cd $(dirname $0)/.. && pwd)
readonly framework="$root/Maio.framework"
echo "root: $root"

# 引数からMaio.frameworkを持ってくる

# Maio.frameworkであるかの検証
# - 指定先がディレクトリでなければダメ
# - ディレクトリでも、Info.plistを直下に持っていなければダメ
if [ $# -ne 1 ]; then
    echo "argument error: 引数には差し替えるMaio.frameworkへのパスが必要です。" 1>&2
    exit 1
fi
if ! [ -d $1 ] || ! [ -f $1/Info.plist ]  ; then
    echo "argument error: $1: Maio.frameworkではない可能性があります。" 1>&2
    exit 1
fi

rm -rf $framework
if ! cp -af $1 $framework; then
    echo "copy failded" 1>&2
    # Maio.frameworkをリカバリーする
    $(cd $root && git checkout -- $framework)
    exit 1
fi

# 差分があるか確認する
$(cd $root && git add Maio.framework)
readonly diff_filenames=$(cd $root && git diff --cached --name-only)
if [ $(cd $root && git diff --cached --name-only | wc -l) -eq 0 ]; then
    echo "変更はありません"
    exit 0
fi

exit 0
