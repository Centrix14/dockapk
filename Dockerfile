FROM alpine:3 AS downloader

LABEL name="dockapk"
LABEL version=8
LABEL description="Simple Docker image for building APK files; created as educational task"

WORKDIR /
RUN wget -cO cmdline-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip
RUN unzip cmdline-tools.zip

RUN wget -cO app.zip https://github.com/Julow/Unexpected-Keyboard/archive/refs/tags/1.32.1.zip
RUN unzip app.zip

FROM eclipse-temurin:17 AS builder

VOLUME /dockapk-output
COPY --from=downloader /Unexpected-Keyboard-1.32.1 /app
COPY --from=downloader /cmdline-tools /android/cmdline-tools/latest
COPY entrypoint.sh /

WORKDIR /android/cmdline-tools
ENV ANDROID_HOME=/android
ENV APP_PATH=/app

WORKDIR /android/cmdline-tools/latest/bin

RUN yes | ./sdkmanager --licenses
RUN ./sdkmanager --install "build-tools;34.0.0" \
                           "platform-tools" \
                           "platforms;android-35"
RUN $APP_PATH/gradlew --version --no-daemon

ENTRYPOINT ["/entrypoint.sh"]