@echo off
setlocal enabledelayedexpansion

REM ---------- CONFIG START ----------
set PYTHON_VERSION=3.11
set ARCH=120
set PKG_NAME=llama-cpp-python[server]
REM ---------- CONFIG END ------------
set ARCHS=86 89 120 86;89;120
set PKG_NAMES=llama-cpp-python llama-cpp-python[server]

REM Clean the temp
set TEMP_DIR=D:\temp
echo Cleaning TEMP folders...
del /s /q "%TMP%\*" >nul 2>&1
for /d %%x in ("%TMP%\*") do rd /s /q "%%x" >nul 2>&1
if /I not "%TEMP%"=="%TMP%" (
    del /s /q "%TEMP%\*" >nul 2>&1
    for /d %%x in ("%TEMP%\*") do rd /s /q "%%x" >nul 2>&1
)
echo Temp folders cleaned.
REM Clear the cache
echo Clearing pip cache...
pip cache purge

REM virtual env
set "ARCH_FOLDER=!ARCH!-!PKG_NAME!"
set "VENV_NAME=.venv_!ARCH_FOLDER!"

echo Creating virtual environment: !VENV_NAME!
py -%PYTHON_VERSION% -m venv %VENV_NAME%
call %VENV_NAME%\Scripts\activate
REM where python
echo Installing build tools...
python -m pip install --upgrade pip setuptools wheel

REM Set environment and build args
set TEMP=%TEMP_DIR%
set TMP=%TEMP_DIR%
set FORCE_CMAKE=1
set GGML_CUDA=1
set CMAKE_ARGS=-DGGML_CUDA=on -DCMAKE_CUDA_ARCHITECTURES=%ARCH%

REM Compile the llama cpp python
echo Building: !PKG_NAME! for arch: %ARCH%
pip install --verbose --force-reinstall --no-binary :all: !PKG_NAME!

REM Save the wheel iles
set "BUILD_DIR=wheel-!ARCH_FOLDER!"
mkdir "!BUILD_DIR!"
cd "!BUILD_DIR!"
pip wheel !PKG_NAME!
cd ..
call %VENV_NAME%\Scripts\deactivate
echo build complete.
