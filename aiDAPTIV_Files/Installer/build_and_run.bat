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
:: AUTO CREATE CACHE DIRECTORY + COPY FILES
::----------------------------------------------------------
set "FLOW_UUID=e7e17006-738b-45e4-8184-141f18c86d9a"
set "CACHE_ROOT=%LOCALAPPDATA%\langflow\langflow\Cache"
set "FLOW_CACHE_DIR=%CACHE_ROOT%\%FLOW_UUID%"

set "SOURCE_DOCS=%INSTALLER_DIR%\docs\%FLOW_UUID%"
@REM set "SOURCE_DOCS=C:\Users\Swift16\Desktop\dev_langflow\aiDAPTIV_Langflow\docs\%FLOW_UUID%"
echo SOURCE_DOCS is "%SOURCE_DOCS%"
echo [INFO] Ensuring cache directory exists:
echo         %FLOW_CACHE_DIR%
echo.

if not exist "%FLOW_CACHE_DIR%" (
    echo [INFO] Creating cache folder...
    mkdir "%FLOW_CACHE_DIR%"
) else (
    echo [INFO] Cache folder already exists.
)

echo [INFO] Copying Docs from:
echo         %SOURCE_DOCS%
echo         to
echo         %FLOW_CACHE_DIR%
echo.

if exist "%SOURCE_DOCS%" (
    xcopy "%SOURCE_DOCS%\*" "%FLOW_CACHE_DIR%\" /Y /I /E /Q
    echo [INFO] Files copied successfully.
) else (
    echo "%SOURCE_DOCS%"
    echo [WARN] Source docs folder does not exist. Skipping copy.
)

::----------------------------------------------------------
:: Set custom components path (portable)
::----------------------------------------------------------

timeout /t 5 /nobreak > nul

echo.


::----------------------------------------------------------
:: Launch Langflow Backend
::----------------------------------------------------------
echo =======================================
echo   Launching Langflow Backend
echo =======================================
echo.
pushd "%LANGFLOW_BASE_PATH%"

::----------------------------------------------------------
:: Load .env variables into the environment
::----------------------------------------------------------
if exist "%ENV_FILE%" (
    echo [INFO] Loading environment variables from: %ENV_FILE%
    
    :: Read and set environment variables from .env file
    for /f "tokens=1,* delims==" %%a in ('type "%ENV_FILE%" ^| findstr /r /v "^#.*" ^| findstr /r /v "^\s*$"') do (
        set "%%a=%%b"
        echo [INFO] Set Env Var: %%a
    )
    
    :: Now, the variables are set in the current environment
    :: The uvicorn command can be simplified as it will read the existing env vars
    echo [INFO] Starting Langflow Backend with loaded environment.
    start "Langflow Backend" "%PYTHON_EXE%" -m uvicorn --factory langflow.main:setup_app --host 127.0.0.1 --port 7860 --loop asyncio
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
