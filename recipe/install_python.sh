#!/bin/bash

set -xe

# now re-configure with BUILD_PYTHON_BINDINGS:BOOL=ON

# suggested addition per conda-forge/gdal-feedstock/651
export CXXFLAGS="${CXXFLAGS} -std=c++17 -D_LIBCPP_DISABLE_AVAILABILITY"

mkdir pybuild_${PKG_HASH}
pushd pybuild_${PKG_HASH}

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


cd swig/python

cat >pyproject.toml <<EOF
[build-system]
requires = ["setuptools>=40.8.0", "wheel"]
build-backend = "setuptools.build_meta"
EOF

cmake --build . --target python_wheel

$PYTHON -m pip install --no-deps --ignore-installed .

popd
