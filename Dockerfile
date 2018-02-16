FROM    python:3.6-slim

RUN     apt-get update && \
        apt-get install -y \
            automake \
            bison \
            build-essential \
            cmake \
            libboost-dev \
            libgl1-mesa-dev \
            libglu1-mesa-dev \
            libharfbuzz-dev \
            libpcre3-dev \
            wget

WORKDIR /tmp/build

ARG     SWIG_VERSION=3.0.9
COPY    build_swig.sh /tmp
RUN     ../build_swig.sh $SWIG_VERSION

ARG     FREETYPE_VERSION=2.6.3
COPY    build_freetype.sh /tmp
RUN     ../build_freetype.sh $FREETYPE_VERSION

ARG     OCE_VERSION=0.18.3
COPY    build_oce.sh /tmp
RUN     ../build_oce.sh $OCE_VERSION

ARG     SMESH_VERSION=6.7.6
COPY    build_smesh.sh /tmp
RUN     ../build_smesh.sh $SMESH_VERSION

ARG     PYTHONOCC_CORE_VERSION=0.18.1
COPY    build_pythonocc_core.sh /tmp
RUN     ../build_pythonocc_core.sh $PYTHONOCC_CORE_VERSION

WORKDIR /

RUN     apt-get remove --auto-remove -y \
            automake \
            bison \
            build-essential \
            cmake \
            libboost-dev \
            libpcre3-dev \
            wget && \
        rm -rf /var/lib/apt/lists/*

