
mkdir pybuild_%PKG_HASH%
if errorlevel 1 exit 1
cd pybuild_%PKG_HASH%
if errorlevel 1 exit 1

if  %vc% LEQ 9 set MSVC_VER=1500
if  %vc% GTR 9 set MSVC_VER=1900

if  %vc% LEQ 9 set MSVC_TS_VER=90
if  %vc% GTR 9 set MSVC_TS_VER=140

cmake -G "Ninja" ^
      "%CMAKE_ARGS%" ^
      -DMSVC_VERSION="%MSVC_VER%" ^
      -DMSVC_TOOLSET_VERSION="%MSVC_TS_VER%" ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DCMAKE_PREFIX_PATH:PATH="%LIBRARY_PREFIX%" ^
      -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
      -DGDAL_PYTHON_INSTALL_PREFIX:PATH="%STDLIB_DIR%\.." ^
      -DBUILD_SHARED_LIBS=ON ^
      -DPython_EXECUTABLE="%PYTHON%" ^
      -DBUILD_PYTHON_BINDINGS:BOOL=ON ^
      -DBUILD_JAVA_BINDINGS:BOOL=OFF ^
      -DBUILD_CSHARP_BINDINGS:BOOL=OFF ^
      -DGDAL_USE_KEA:BOOL=ON ^
      -DKEA_INCLUDE_DIR:PATH="%LIBRARY_INC%" ^
      -DKEA_LIBRARY:PATH="%LIBRARY_LIB%\libkea.lib" ^
      -DGDAL_USE_MYSQL:BOOL=OFF ^
      "%SRC_DIR%"

if errorlevel 1 exit /b 1

cd %SRC_DIR%\swig\python
if errorlevel 1 exit /b 1
%PYTHON% %SRC_DIR%\pybuild_%PKG_HASH%\swig\python\setup.py install
if errorlevel 1 exit /b 1
