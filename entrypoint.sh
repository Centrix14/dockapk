#!/bin/sh
cd $APP_PATH
./gradlew --no-daemon assembleDebug
cp /app/build/outputs/apk/debug/juloo.keyboard2.debug.apk \
   /dockapk-output/unexpected-keyboard.apk
