#!/bin/bash

echo "Start Maio.xcframework Update script."

readonly ROOT=$(cd $(dirname $0)/.. && pwd)
readonly FRAMEWORK="$ROOT/Maio.xcframework"
echo "root: $ROOT"

# 引数からMaio.xcframeworkを持ってくる

# Maio.xcframeworkであるかの検証
# - 指定先がディレクトリでなければダメ
# - ディレクトリでも、Info.plistを直下に持っていなければダメ
if [ $# -ne 1 ]; then
    echo "argument error: 引数には差し替えるMaio.xcframeworkへのパスが必要です。" 1>&2
    exit 1
fi
if ! [ -d $1 ] || ! [ -f $1/Info.plist ]  ; then
    echo "argument error: $1: Maio.xcframeworkではない可能性があります。" 1>&2
    exit 1
fi

rm -rf $FRAMEWORK
if ! cp -af $1 $FRAMEWORK; then
    echo "copy failded" 1>&2
    # Maio.xcframeworkをリカバリーする
    echo $(cd $ROOT && git checkout -- $FRAMEWORK)
    exit 1
fi

# 差分があるか確認する
$(cd $ROOT && git add $FRAMEWORK)
readonly DIFF_FILENAMES=$(cd $ROOT && git diff --cached --name-only $FRAMEWORK)
if [ -z "$DIFF_FILENAMES" ]; then
    echo "変更はありません"
    exit 0
fi

echo ""
echo "差分のあるファイル名を列挙します。"
for item in $DIFF_FILENAMES
do
    echo $item
done

# バージョン番号更新チェック
## 現行タグから最新バージョン番号を取得
readonly LATEST_VERSION=$(git tag | sort -t. -k 1.2,1n -k 2,2n -k 3,3n |tail -1)
echo ""
echo "latest: $LATEST_VERSION"


readonly TARGET_VERSION="v$(plutil -p $(find $FRAMEWORK/*/Maio.framework -name Info.plist | head -n 1) | grep "CFBundleShortVersionString" | sed -e "s/[^0-9.]//g")"
echo "target: $TARGET_VERSION"

readonly HIGHER_VERSION=$(for v in $LATEST_VERSION $TARGET_VERSION; do echo "$v"; done | sort -t. -k 1.2,1n -k 2,2n -k 3,3n |tail -1)
echo "higher: $HIGHER_VERSION"

if [ $LATEST_VERSION == $TARGET_VERSION ] ||
   [ $HIGHER_VERSION != $TARGET_VERSION ]; then
    echo "バージョン番号を更新する必要があります。" 1>&2
    # Maio.xcframeworkをリカバリーする
    echo $(cd $ROOT && git reset HEAD $DIFF_FILENAMES) > /dev/null
    rm -rf $FRAMEWORK
    echo $(cd $ROOT && git checkout -- $FRAMEWORK)
    exit 1
fi

set -u
onExit() {
    echo "exit"
    [[ -n $tmpfile ]] && rm -f "$tmpfile"
    [[ -n $tmprelease ]] && rm -f "$tmprelease"
}
tmpfile=$(mktemp)
tmprelease=$(mktemp)
trap onExit EXIT
trap 'echo "trap">&2;trap - EXIT; onExit; exit -1' SIGHUP SIGINT SIGTERM

echo "" >> $tmpfile
echo "# リリースノートの内容を入力してください。" >> $tmpfile
echo "# '#'で始まる行は無視されます。" >> $tmpfile
vi $tmpfile

releaseNote=$(cat $tmpfile | sed "/^#/d" | sed -E "s/[ 　]*$//g" | tr -s "\n")
echo ""
echo "リリースノート"
echo ""
echo "## $TARGET_VERSION"
echo "$releaseNote"

echo ""
echo "コミットしてよろしいですか？(y/N)"
read key
while [ -z $key ]
do
    read key
done

if [ "$key" != "y" ]; then
    echo "終了します。"
    # Maio.xcframeworkをリカバリーする
    echo $(cd $ROOT && git reset HEAD $DIFF_FILENAMES) > /dev/null
    rm -rf $FRAMEWORK
    echo $(cd $ROOT && git checkout -- $FRAMEWORK)
    exit 0
fi

echo $(cd $ROOT && git checkout -b "release/${TARGET_VERSION}") > /dev/null

echo $(cd $ROOT && git commit -m "Maio.xcframeworkを${TARGET_VERSION}に更新") > /dev/null

readonly TODAY=$(date "+%Y/%m/%d")
sed -i '' -E "s/(Version: ?).*$/\1${TARGET_VERSION#v}/" $ROOT/README.md
sed -i '' -E "s/(Released: ?)[0-9/]+/\1${TODAY//\//\\/}/" $ROOT/README.md
echo $(cd $ROOT && git add $ROOT/README.md) > /dev/null
echo $(cd $ROOT && git commit -m "READMEのリリースバージョン、リリース日を更新") > /dev/null

{
    head -2 $ROOT/release-notes.md
    echo "## $TARGET_VERSION (${TODAY//\//-})"
    echo "$releaseNote"
    echo ""
    sed "1,2d" $ROOT/release-notes.md
} >> $tmprelease
cat $tmprelease > $ROOT/release-notes.md

echo $(cd $ROOT && git add $ROOT/release-notes.md) > /dev/null
echo $(cd $ROOT && git commit -m "リリースノートを追加")  > /dev/null

echo "ブランチの追加、コミットを完了しました。"
echo "プッシュ及び、プルリクエストを作成してください。"

exit 0
