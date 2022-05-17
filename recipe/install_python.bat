rem set LIBRARY_INC=%PREFIX%\Library\include
rem set LIBRARY_LIB=%PREFIX%\Library\lib

rem pushd swig\python

rem %PYTHON% setup.py build_ext ^
rem         --include-dirs %LIBRARY_INC% ^
rem         --library-dirs %LIBRARY_LIB% ^
rem         --gdal-config gdal-config
rem %PYTHON% setup.py build_py
rem %PYTHON% setup.py build_scripts
rem %PYTHON% setup.py install

rem popd
