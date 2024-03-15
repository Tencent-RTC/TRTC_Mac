#!/usr/bin/env bash

#WORKSPACE=$(pwd)

# -----------------------------
# 功能： 打包之前，清理result目录
# -----------------------------
if [ -e result ] ;then
rm -r result
fi
mkdir result

# 进入TRTCSimpleDemo目录
cd Mac/TRTCSimpleDemo

# -----------------------------
# 功能： 打包github源码
# github源码 压缩zip
sed -i '' 's/1400188366/<#appid#>/g' debug/GenerateTestUserSig.h
sed -i '' 's/545c310386e04eed7f8ceff9c7342744725d13f2215f0f99892df85962790900/<#SDKSECRETKEY#>/' debug/GenerateTestUserSig.h

cd ..
zip -q -r -o $WORKSPACE/result/TRTCSimpleDemo.zip ./ -x TRTCSimpleDemo/build.sh -x "SDK/TXLiteAVSDK_TRTC_Mac.framework/*" -x "TRTCScenesDemo/*" -x "TRTCSimpleDemo/Pods/*"
# -----------------------------