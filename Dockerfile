FROM python:3.6

ENV PYTHONUNBUFFERED 1

#### Install GEOS ####
# Inspired by: https://hub.docker.com/r/cactusbone/postgres-postgis-sfcgal/~/dockerfile/

ENV GEOS http://download.osgeo.org/geos/geos-3.6.2.tar.bz2

ADD $GEOS /install-postgis/

WORKDIR /install-postgis/geos-3.6.2/

RUN ./configure --enable-python && make -j $(nproc) && make install
RUN ldconfig
RUN geos-config --cflags

RUN apt-get update && apt-get install -y binutils libproj-dev gdal-bin 
