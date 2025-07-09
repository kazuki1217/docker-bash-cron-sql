#!/bin/bash

# ログを出力する関数
# $1 = ログレベル
# $2 = メッセージ
log() {
    local level="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] $2"
}
