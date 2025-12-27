# About
dockapk is a sample docker image for building Android apk files. It can be used as an example or reference for real dockerfiles.

# Prerequisites
dockapk is tested with `Docker version 29.0.4, build 3247a5a`. Application used for testing is an [Unexpected Keyboard](https://github.com/Julow/Unexpected-Keyboard).

dockapk requires proper internet connection for building (downloading of Andoid SDK and application sources) and running (automatic Gradle installation and ). Internet usage in run-time can be eliminated with proper Gradle installation in build-time.

Image uses volume `/dockapk-output` for exporting data. You can create corresponding volume with something like this:

``` shell
docker volume create --name dockapk-output
```

Output files will be stored in Docker volumes directory. On my machine is a `/var/lib/docker/volumes/dockapk-output/_data/`.

# Usage
To build image use command like this:

``` shell
sudo docker build --network=host -t dockapk:5 .
```

To run container you will need proper network setup (i just used host-machine network) and `--mount` flag configuration. Typical run command will be follows:

``` shell
docker run \
       --net=host \
       --mount type=volume,source=dockapk-output,destination=/dockapk-output \
       dockapk:5
```

This command can be found in `run.sh` file.

Builded APK will be exported to volume automatically when container finish work.

# Image overview
dockapk building is comprising of two stages: download stage and build stage.

`Download` stage using `alpine:3` base layer and wget for downloading file.

`Build` stage using `gradle:9.2.1-jdk17` base layer. Gradle itself is not required (since it automatically installs via `gradlew`) but this image used as JDK17 provider. For newer apps another JDK revisions can be used.

At building stage image installs: "build-tools;30.0.0", "platform-tools", "platforms;android-11".

Running container starts `entrypoint.sh`:

``` shell
cd $APP_PATH
./gradlew --no-daemon assembleDebug
cp /app/build/outputs/apk/debug/juloo.keyboard2.debug.apk \
   /dockapk-output/unexpected-keyboard.apk
```
