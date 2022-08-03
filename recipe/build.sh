#!/bin/bash
# Get an updated config.sub and config.guess
# cp $BUILD_PREFIX/share/gnuconfig/config.* .

set -ex # Abort on error.

# recommended in https://gitter.im/conda-forge/conda-forge.github.io?at=5c40da7f95e17b45256960ce
# find ${PREFIX}/lib -name '*.la' -delete

# Force python bindings to not be built.
# unset PYTHON

# export CPPFLAGS="${CPPFLAGS} -I${PREFIX}/include"
# # Remove -std=c++XX from build ${CXXFLAGS}
# CXXFLAGS=$(echo "${CXXFLAGS}" | sed -E 's@-std=c\+\+[^ ]+@@g')
# export CXXFLAGS="${CXXFLAGS} -std=c++17"
# also allow newer symbols (https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk)
export CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"

mkdir build
cd build

cmake -G "Unix Makefiles" \
      ${CMAKE_ARGS} \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_PREFIX_PATH=$PREFIX \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DBUILD_SHARED_LIBS=ON \
      -DPython_EXECUTABLE="$PYTHON" \
      -DBUILD_PYTHON_BINDINGS:BOOL=OFF \
      -DBUILD_JAVA_BINDINGS:BOOL=OFF \
      -DBUILD_CSHARP_BINDINGS:BOOL=OFF \
      ${SRC_DIR}

cmake --build . -j ${CPU_COUNT} --config Release


# (bash configure --prefix=${PREFIX} \
#                --host=${HOST} \
#                --with-blosc=${PREFIX} \
#                --with-curl \
#                --with-dods-root=${PREFIX} \
#                --with-expat=${PREFIX} \
#                --with-freexl=${PREFIX} \
#                --with-geos=${PREFIX}/bin/geos-config \
#                --with-geotiff=${PREFIX} \
#                --with-hdf4=${PREFIX} \
#                --with-cfitsio=${PREFIX} \
#                --with-hdf5=${PREFIX} \
#                --with-tiledb=${PREFIX} \
#                --with-jpeg=${PREFIX} \
#                --with-kea=${PREFIX}/bin/kea-config \
#                --with-libiconv-prefix=${PREFIX} \
#                --with-libjson-c=${PREFIX} \
#                --with-libkml=${PREFIX} \
#                --with-liblzma=yes \
#                --with-libtiff=${PREFIX} \
#                --with-libz=${PREFIX} \
#                --with-netcdf=${PREFIX} \
#                --with-openjpeg=${PREFIX} \
#                --with-pcre \
#                --with-pg=yes \
#                --with-png=${PREFIX} \
#                --with-poppler=${PREFIX} \
#                --with-spatialite=${PREFIX} \
#                --with-sqlite3=${PREFIX} \
#                --with-proj=${PREFIX} \
#                --with-webp=${PREFIX} \
#                --with-xerces=${PREFIX} \
#                --with-xml2=yes \
#                --with-zstd=${PREFIX} \
#                --without-python \
#                --disable-static \
#                --verbose \
#                ${OPTS}) || (cat config.log; false)

# make -j $CPU_COUNT ${VERBOSE_AT}
