#!/bin/bash

echo "========================================"
echo "   Deploy Firebase Storage CORS Rules"
echo "========================================"
echo

echo "Checking if gsutil is available..."
if ! command -v gsutil &> /dev/null; then
    echo
    echo "ERROR: gsutil is not found in PATH"
    echo
    echo "Please install Google Cloud SDK and add gsutil to your PATH:"
    echo "1. Download from: https://cloud.google.com/sdk/docs/install"
    echo "2. Run: gcloud auth login"
    echo "3. Run: gcloud config set project appstyle-picked"
    echo
    echo "Or manually set CORS in Firebase Console:"
    echo "1. Go to Firebase Console > Storage"
    echo "2. Click on 'Rules' tab"
    echo "3. Upload the CORS configuration"
    echo
    exit 1
fi

echo "gsutil found! Checking authentication..."
if ! gsutil ls gs://appstyle-picked.firebasestorage.app &> /dev/null; then
    echo
    echo "ERROR: Not authenticated or no access to Firebase Storage"
    echo
    echo "Please run:"
    echo "  gcloud auth login"
    echo "  gcloud config set project appstyle-picked"
    echo
    exit 1
fi

echo "Authentication successful!"
echo

echo "Setting CORS configuration..."
if gsutil cors set firebase-storage-cors.json gs://appstyle-picked.firebasestorage.app; then
    echo
    echo "========================================"
    echo "   CORS Configuration Applied Successfully!"
    echo "========================================"
    echo
    echo "CORS rules have been applied to Firebase Storage."
    echo "You can now test image loading in your app."
    echo
else
    echo
    echo "========================================"
    echo "   CORS Configuration Failed!"
    echo "========================================"
    echo
    echo "There was an error applying CORS configuration."
    echo "Please check the error message above."
    echo
fi

echo
echo "Current CORS configuration:"
gsutil cors get gs://appstyle-picked.firebasestorage.app

echo

