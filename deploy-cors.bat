@echo off
echo ========================================
echo   Deploy Firebase Storage CORS Rules
echo ========================================
echo.

echo Checking if gsutil is available...
where gsutil >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ERROR: gsutil is not found in PATH
    echo.
    echo Please install Google Cloud SDK and add gsutil to your PATH:
    echo 1. Download from: https://cloud.google.com/sdk/docs/install
    echo 2. Run: gcloud auth login
    echo 3. Run: gcloud config set project appstyle-picked
    echo.
    echo Or manually set CORS in Firebase Console:
    echo 1. Go to Firebase Console ^> Storage
    echo 2. Click on "Rules" tab
    echo 3. Upload the CORS configuration
    echo.
    pause
    exit /b 1
)

echo gsutil found! Checking authentication...
gsutil ls gs://appstyle-picked.firebasestorage.app >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Not authenticated or no access to Firebase Storage
    echo.
    echo Please run:
    echo   gcloud auth login
    echo   gcloud config set project appstyle-picked
    echo.
    pause
    exit /b 1
)

echo Authentication successful!
echo.

echo Setting CORS configuration...
gsutil cors set firebase-storage-cors.json gs://appstyle-picked.firebasestorage.app

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo   CORS Configuration Applied Successfully!
    echo ========================================
    echo.
    echo CORS rules have been applied to Firebase Storage.
    echo You can now test image loading in your app.
    echo.
) else (
    echo.
    echo ========================================
    echo   CORS Configuration Failed!
    echo ========================================
    echo.
    echo There was an error applying CORS configuration.
    echo Please check the error message above.
    echo.
)

echo.
echo Current CORS configuration:
gsutil cors get gs://appstyle-picked.firebasestorage.app

echo.
pause

