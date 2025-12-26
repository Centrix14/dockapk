FROM alpine:3 AS downloader

LABEL name="dockapk"
LABEL version=0
LABEL description="Simple Docker image for building APK files; created as educational task"

WORKDIR /
RUN wget -cO cmdline-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip
RUN unzip cmdline-tools.zip

FROM gradle:9.2.1-jdk17 AS builder

WORKDIR /android/cmdline-tools
COPY --from=downloader /cmdline-tools latest

ENV ANDROID_HOME=/android

WORKDIR /android/cmdline-tools/latest/bin

RUN yes | ./sdkmanager --licenses
RUN ./sdkmanager --install "build-tools;30.0.0" \
                           "platform-tools" \
                           "platforms;android-11"
