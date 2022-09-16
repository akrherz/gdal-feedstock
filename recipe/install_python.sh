#!/bin/bash

# now re-configure with BUILD_PYTHON_BINDINGS:BOOL=ON

mkdir pybuild_${PKG_HASH}
cd pybuild_${PKG_HASH}

cmake -G "Unix Makefiles" \
      ${CMAKE_ARGS} \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_PREFIX_PATH=$PREFIX \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DBUILD_SHARED_LIBS=ON \
      -DPython_EXECUTABLE="$PYTHON" \
      -DBUILD_PYTHON_BINDINGS:BOOL=ON \
      -DBUILD_JAVA_BINDINGS:BOOL=OFF \
      -DBUILD_CSHARP_BINDINGS:BOOL=OFF \
      ${SRC_DIR} || (cat CMakeFiles/CMakeError.log;false)


pushd ${SRC_DIR}/swig/python

$PYTHON -m pip install --no-deps --ignore-installed . \
        --global-option build_ext \
        --global-option "-I$INCLUDE_PATH" \
        --global-option "-L$LIBRARY_PATH"

popd
