cd build
if errorlevel 1 exit 1

cmake --build . --config Release --target install
if errorlevel 1 exit /b 1

set ACTIVATE_DIR=%PREFIX%\etc\conda\activate.d
set DEACTIVATE_DIR=%PREFIX%\etc\conda\deactivate.d
mkdir %ACTIVATE_DIR%
mkdir %DEACTIVATE_DIR%

copy %RECIPE_DIR%\scripts\activate.bat %ACTIVATE_DIR%\gdal-activate.bat
if errorlevel 1 exit 1

copy %RECIPE_DIR%\scripts\deactivate.bat %DEACTIVATE_DIR%\gdal-deactivate.bat
if errorlevel 1 exit 1


:: Copy powershell activation scripts
copy %RECIPE_DIR%\scripts\activate.ps1 %ACTIVATE_DIR%\gdal-activate.ps1
if errorlevel 1 exit 1

copy %RECIPE_DIR%\scripts\deactivate.ps1 %DEACTIVATE_DIR%\gdal-deactivate.ps1
if errorlevel 1 exit 1



:: Copy unix shell activation scripts, needed by Windows Bash users
copy %RECIPE_DIR%\scripts\activate.sh %ACTIVATE_DIR%\gdal-activate.sh
if errorlevel 1 exit 1

copy %RECIPE_DIR%\scripts\deactivate.sh %DEACTIVATE_DIR%\gdal-deactivate.sh
if errorlevel 1 exit 1
