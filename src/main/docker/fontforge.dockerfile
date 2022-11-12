FROM ubuntu:jammy
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get install -y --fix-missing --no-install-recommends \
        git libjpeg-dev libtiff5-dev libpng-dev libfreetype6-dev libgif-dev libgtk-3-dev libxml2-dev libpango1.0-dev \
        libcairo2-dev libspiro-dev python3-dev ninja-build cmake build-essential gettext \
        apt-transport-https ca-certificates

RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update
RUN apt-get -y install python3.8

RUN mkdir -p /fontforge

RUN git clone https://github.com/fontforge/fontforge.git /fontforge

WORKDIR /fontforge

ENV FFCONFIG=-DCMAKE_INSTALL_PREFIX=$PREFIX -DENABLE_FONTFORGE_EXTRAS=ON -DENABLE_PYTHON_SCRIPTING=ON

ENV FFCONFIG=$FFCONFIG -DENABLE_GUI=OFF 
# the line above was copied from fontforge github action, it ended with "-DENABLE_PYTHON_SCRIPTING=OFF"

RUN mkdir build \
    && cd build \
    && cmake -GNinja $FFCONFIG .. \
    && cd ..
RUN ninja -C build all potfiles install

RUN mkdir /app
WORKDIR /app

# RUN useradd -u 1000 -m -G video forge
# USER forge
CMD ["fontforge"]