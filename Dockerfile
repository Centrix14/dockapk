FROM debian:13
LABEL name="dockapk"
LABEL version=0
LABEL description="Simple Docker image for building APK files; created as educational task"
RUN apt-get update && apt-get install -y wget unzip
RUN wget -q -O cmdline-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip
RUN unzip cmdline-tools.zip
WORKDIR /cmdline-tools/bin
# затем прописать установку всего необходимого через sdkmanager