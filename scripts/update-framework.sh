#!/bin/bash

echo "Start Maio.framework pdate script."

readonly ROOT=$(cd $(dirname $0)/.. && pwd)
readonly FRAMEWORK="$ROOT/Maio.framework"
echo "root: $ROOT"

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

rm -rf $FRAMEWORK
if ! cp -af $1 $FRAMEWORK; then
    echo "copy failded" 1>&2
    # Maio.frameworkをリカバリーする
    $(cd $ROOT && git checkout -- $FRAMEWORK)
    exit 1
fi

# 差分があるか確認する
$(cd $ROOT && git add $FRAMEWORK)
readonly DIFF_FILENAMES=$(cd $ROOT && git diff --cached --name-only $FRAMEWORK)
if [ -z $DIFF_FILENAMES ]; then
    echo "変更はありません"
    exit 0
fi

echo "差分のあるファイル名を列挙します。"
echo $DIFF_FILENAMES

echo "コミットしてよろしいですか？(y/N)"
read key
while [ -z $key ]
do
    read key
done

if [ "$key" != "y" ]; then
    echo "終了します。"
    # Maio.frameworkをリカバリーする
    echo $(cd $ROOT && git reset HEAD $DIFF_FILENAMES) > /dev/null
    rm -rf $FRAMEWORK
    $(cd $ROOT && git checkout -- $FRAMEWORK)
fi

exit 0
