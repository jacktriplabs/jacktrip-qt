# JackTrip build container for Qt

# container image versions
ARG BUILD_CONTAINER=ubuntu:20.04

FROM ${BUILD_CONTAINER} AS builder

WORKDIR /root

# install required packages
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
  && apt-get install -yq --no-install-recommends xz-utils curl wget make gcc g++ libclang-dev libclang-11-dev llvm-11-dev ninja-build python3-pip \
  && apt-get install -yq --no-install-recommends libfreetype6-dev libxi-dev libxkbcommon-dev libxkbcommon-x11-dev libx11-xcb-dev libdrm-dev libglu1-mesa-dev libwayland-dev libwayland-egl1-mesa libgles2-mesa-dev libwayland-server0 libwayland-egl-backend-dev libxcb1-dev libxext-dev libfontconfig1-dev libxrender-dev libxcb-keysyms1-dev libxcb-image0-dev libxcb-shm0-dev libxcb-icccm4-dev '^libxcb.*-dev' libxcb-render-util0-dev libxcomposite-dev libgtk-3-dev

# install html5lib and more recent cmake for qt6
ARG QT_VERSION=6.5.3
ENV QT_VERSION=$QT_VERSION
RUN if [ `echo "$QT_VERSION" | grep "^6\..*"` ]; then \
  pip3 install html5lib \
  && apt-get install -yq --no-install-recommends software-properties-common lsb-release \
  && wget --no-check-certificate -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null \
  && apt-add-repository "deb https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main" \
  && apt-get update \
  && apt-get install -yq --no-install-recommends cmake \
  ; fi

# build qt
COPY patches ./patches
COPY qtbuild.sh ./qtbuild.sh
ARG QT_TYPE=static
ENV QT_TYPE=$QT_TYPE
RUN if [ "$QT_TYPE" = "dynamic" ]; then ./qtbuild.sh -dynamic $QT_VERSION; else ./qtbuild.sh $QT_VERSION; fi
RUN tar -C /opt -czf "qt-${QT_VERSION}-${QT_TYPE}.tar.gz" "qt-${QT_VERSION}-${QT_TYPE}"

# collect build artifacts
FROM scratch AS artifact
COPY --from=builder /root/qt-*.tar.gz /
