@echo off
REM Setup script for all Kaiburr repositories (Windows)
REM This script sets up CI/CD for both backend and frontend repositories

echo 🚀 Setting up Kaiburr CICD Pipeline for All Repositories
echo ========================================================

REM Check if we're in the right directory
if not exist "README.md" (
    echo ❌ Error: Please run this script from the Kaiburr_CICD repository root
    pause
    exit /b 1
)

if not exist "workflows" (
    echo ❌ Error: workflows directory not found
    pause
    exit /b 1
)

if not exist "scripts" (
    echo ❌ Error: scripts directory not found
    pause
    exit /b 1
)

echo ✅ Found CICD repository structure

REM Get the parent directory
for %%i in ("%~dp0..") do set PARENT_DIR=%%~fi
set BACKEND_DIR=%PARENT_DIR%\Kaiburr_Task_1
set FRONTEND_DIR=%PARENT_DIR%\Kaiburr_Task_3

echo 📁 Parent directory: %PARENT_DIR%
echo 📁 Backend directory: %BACKEND_DIR%
echo 📁 Frontend directory: %FRONTEND_DIR%

echo.
echo 🔧 Setting up Backend Repository...

REM Setup backend
if not exist "%BACKEND_DIR%" (
    echo ⚠️  Backend directory not found. Cloning from GitHub...
    cd /d "%PARENT_DIR%"
    git clone https://github.com/zeusXtruealpha/Kaiburr_Task_1.git
    cd Kaiburr_Task_1
) else (
    echo ✅ Backend directory found. Updating...
    cd /d "%BACKEND_DIR%"
    git pull origin main
)

REM Create .github/workflows directory
if not exist ".github\workflows" mkdir .github\workflows

REM Copy CI/CD files
echo 📋 Copying CI/CD files to backend...
copy "..\Kaiburr_CICD\workflows\backend-ci-no-docker.yml" ".github\workflows\ci.yml" >nul
copy "..\Kaiburr_CICD\workflows\backend-deploy.yml" ".github\workflows\deploy.yml" >nul

REM Update .gitignore
findstr /C:"target/" .gitignore >nul 2>&1
if errorlevel 1 (
    echo. >> .gitignore
    echo # Maven >> .gitignore
    echo target/ >> .gitignore
    echo .mvn/wrapper/maven-wrapper.jar >> .gitignore
    echo ✅ Updated .gitignore
)

REM Test Maven build
echo 🔨 Testing Maven build...
mvn -B clean compile -DskipTests
if errorlevel 1 (
    echo ❌ Maven build failed
    pause
    exit /b 1
) else (
    echo ✅ Maven build successful
)

REM Test Maven tests (if MongoDB is running)
echo 🧪 Testing Maven tests...
mvn -B test
if errorlevel 1 (
    echo ⚠️  Maven tests failed (MongoDB might not be running)
) else (
    echo ✅ Maven tests successful
)

echo ✅ Backend setup complete!

echo.
echo 🔧 Setting up Frontend Repository...

REM Setup frontend
if not exist "%FRONTEND_DIR%" (
    echo ⚠️  Frontend directory not found. Cloning from GitHub...
    cd /d "%PARENT_DIR%"
    git clone https://github.com/zeusXtruealpha/Kaiburr_Task_3.git
    cd Kaiburr_Task_3
) else (
    echo ✅ Frontend directory found. Updating...
    cd /d "%FRONTEND_DIR%"
    git pull origin main
)

REM Create .github/workflows directory
if not exist ".github\workflows" mkdir .github\workflows

REM Copy CI/CD files
echo 📋 Copying CI/CD files to frontend...
copy "..\Kaiburr_CICD\workflows\frontend-ci-no-docker.yml" ".github\workflows\ci.yml" >nul
copy "..\Kaiburr_CICD\workflows\frontend-deploy.yml" ".github\workflows\deploy.yml" >nul

REM Update .gitignore
findstr /C:"node_modules/" .gitignore >nul 2>&1
if errorlevel 1 (
    echo. >> .gitignore
    echo # Dependencies >> .gitignore
    echo node_modules/ >> .gitignore
    echo dist/ >> .gitignore
    echo .env.local >> .gitignore
    echo .env.development.local >> .gitignore
    echo .env.test.local >> .gitignore
    echo .env.production.local >> .gitignore
    echo ✅ Updated .gitignore
)

REM Test npm build
echo 🔨 Testing npm build...
npm ci
if errorlevel 1 (
    echo ❌ npm install failed
    pause
    exit /b 1
)

npm run build
if errorlevel 1 (
    echo ❌ npm build failed
    pause
    exit /b 1
) else (
    echo ✅ npm build successful
)

echo ✅ Frontend setup complete!

echo.
echo 🎉 All repositories setup complete!
echo.
echo Next steps:
echo 1. Commit and push changes to both repositories:
echo    cd %BACKEND_DIR% ^&^& git add . ^&^& git commit -m "Add CI/CD pipeline" ^&^& git push origin main
echo    cd %FRONTEND_DIR% ^&^& git add . ^&^& git commit -m "Add CI/CD pipeline" ^&^& git push origin main
echo.
echo 2. Check GitHub Actions:
echo    - Backend: https://github.com/zeusXtruealpha/Kaiburr_Task_1/actions
echo    - Frontend: https://github.com/zeusXtruealpha/Kaiburr_Task_3/actions
echo.
echo 3. Configure secrets in repository settings if needed
echo.
echo Happy coding! 🚀
pause
