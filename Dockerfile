# syntax=docker/dockerfile:experimental
FROM ubuntu:18.04 as builder

# Prerequisites
RUN --mount=type=cache,target=/var/cache/apt apt-get update \
  && apt install -y \
  curl \
  git \
  unzip \
  xz-utils \
  zip \
  libglu1-mesa \
  openjdk-8-jdk \
  wget \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Setup new user
RUN useradd -ms /bin/bash developer
USER developer
WORKDIR /home/developer

# Prepare Android directories and system variables
RUN  bash -c 'mkdir -pv {Android/SDK,.android}' \
  && touch .android/repositories.cfg
ENV ANDROID_SDK_ROOT ~/Android/SDK

# Setup Android SDK
# RUN --mount=type=cache,target=/home/developer \
RUN wget -O sdk-tools.zip \
  https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip \
  && rm sdk-tools.zip \
  && mv tools Android/SDK/tools
RUN yes | Android/SDK/tools/bin/sdkmanager --licenses
RUN Android/SDK/tools/bin/sdkmanager \
  "build-tools;29.0.2" \
  "patcher;v4" \
  "platform-tools" \
  "platforms;android-29" \
  "sources;android-29"

# Download Flutter SDK
# RUN --mount=type=cache,target=/home/developer \
RUN git clone -b stable --depth 1 --no-tags https://github.com/flutter/flutter.git
ENV PATH "$PATH:/home/developer/flutter/bin"

# Run basic check to download Dark SDK
RUN flutter doctor

# Create workspace
RUN mkdir /home/developer/workspace
WORKDIR /home/developer/workspace
