FROM ubuntu:kinetic
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get install -y --fix-missing --no-install-recommends \
        git libjpeg-dev libtiff5-dev libpng-dev libfreetype6-dev libgif-dev libgtk-3-dev libxml2-dev libpango1.0-dev \
        libcairo2-dev libspiro-dev python3-dev ninja-build cmake build-essential gettext \
        apt-transport-https ca-certificates

RUN mkdir -p /fontforge

RUN git clone https://github.com/fontforge/fontforge.git /fontforge

WORKDIR /fontforge

ENV FFCONFIG=-DCMAKE_INSTALL_PREFIX=$PREFIX -DENABLE_FONTFORGE_EXTRAS=ON

ENV FFCONFIG=$FFCONFIG -DENABLE_GUI=OFF 
# the line above was copied from fontforge github action, it ended with "-DENABLE_PYTHON_SCRIPTING=OFF"

RUN mkdir build \
    && cd build \
    && cmake -GNinja $FFCONFIG .. \
    && cd ..
RUN ninja -C build all potfiles install

# RUN useradd -u 1000 -m -G video forge
# USER forge
CMD ["fontforge"]