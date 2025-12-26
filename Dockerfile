FROM debian:13-slim
FROM gradle:9.2.1-jdk17

LABEL name="dockapk"
LABEL version=0
LABEL description="Simple Docker image for building APK files; created as educational task"

RUN apt-get update && apt-get install -y wget unzip

WORKDIR /tmp
RUN wget -O cmdline-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip
RUN unzip cmdline-tools.zip

WORKDIR /android/cmdline-tools
RUN mv /tmp/cmdline-tools latest

ENV ANDROID_HOME=/android

WORKDIR /android/cmdline-tools/latest/bin

RUN yes | ./sdkmanager --licenses
RUN ./sdkmanager --install "build-tools;30.0.0"
RUN ./sdkmanager --install "platform-tools"
RUN ./sdkmanager --install "platforms;android-11"
