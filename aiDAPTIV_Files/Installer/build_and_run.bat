@echo off
setlocal enabledelayedexpansion

echo ================================
echo   Starting Langflow Launcher
echo ================================
echo.

::----------------------------------------------------------
:: Installer root folder
::----------------------------------------------------------
set "INSTALLER_DIR=%~dp0"
set "INSTALLER_DIR=%INSTALLER_DIR:~0,-1%"

::----------------------------------------------------------
:: Portable tools
::----------------------------------------------------------
set "PYTHON_DIR=%INSTALLER_DIR%\python"
set "PYTHON_EXE=%PYTHON_DIR%\python.exe"
set "PYTHON_SCRIPTS=%PYTHON_DIR%\Scripts"
set "PATH=%PYTHON_SCRIPTS%;%NODE_DIR%;%PATH%"

::----------------------------------------------------------
:: Check python.exe
::----------------------------------------------------------
if not exist "%PYTHON_EXE%" (
    echo [ERROR] python.exe NOT found in Installer!
    pause
    exit /b 1
)
echo [INFO] Using python at: "%PYTHON_EXE%"

::----------------------------------------------------------
:: Directories and Env
::----------------------------------------------------------
set "FLOWS_DIR=%INSTALLER_DIR%\flows"
set "ENV_FILE=%INSTALLER_DIR%\.env"
set "LANGFLOW_BASE_PATH=%INSTALLER_DIR%\langflow\src\backend\base"

:: Force the Load Flows Path for the backend
set "LANGFLOW_LOAD_FLOWS_PATH=%FLOWS_DIR%"

::----------------------------------------------------------
:: Launch Langflow Backend
::----------------------------------------------------------
echo =======================================
echo   Launching Langflow Backend
echo =======================================
echo.
pushd "%LANGFLOW_BASE_PATH%"

if exist "%ENV_FILE%" (
    echo [INFO] Using .env file at: %ENV_FILE%
    start "Langflow Backend" "%PYTHON_EXE%" -m uvicorn --factory langflow.main:setup_app --host 127.0.0.1 --port 7860 --loop asyncio --env-file "%ENV_FILE%"
) else (
    echo [WARN] No .env file found. Starting without it.
    start "Langflow Backend" "%PYTHON_EXE%" -m uvicorn --factory langflow.main:setup_app --host 127.0.0.1 --port 7860 --loop asyncio
)

if errorlevel 1 goto :error
popd
exit /b 0

:error
echo.
echo [ERROR] Langflow failed to start.
pause
exit /b 1
