#!/bin/bash

echo "========================================"
echo "   Deploy Firebase Storage Rules"
echo "========================================"
echo

echo "Checking if Firebase CLI is available..."
if ! command -v firebase &> /dev/null; then
    echo
    echo "ERROR: Firebase CLI is not found in PATH"
    echo
    echo "Please install Firebase CLI:"
    echo "1. Run: npm install -g firebase-tools"
    echo "2. Run: firebase login"
    echo "3. Run: firebase use appstyle-picked"
    echo
    echo "Or manually deploy rules in Firebase Console:"
    echo "1. Go to Firebase Console > Storage > Rules"
    echo "2. Copy content from firebase-storage.rules"
    echo "3. Paste and Publish"
    echo
    exit 1
fi

echo "Firebase CLI found! Checking authentication..."
if ! firebase projects:list &> /dev/null; then
    echo
    echo "ERROR: Not authenticated with Firebase"
    echo
    echo "Please run:"
    echo "  firebase login"
    echo "  firebase use appstyle-picked"
    echo
    exit 1
fi

echo "Authentication successful!"
echo

echo "Deploying Firebase Storage Rules..."
if firebase deploy --only storage; then
    echo
    echo "========================================"
    echo "   Storage Rules Deployed Successfully!"
    echo "========================================"
    echo
    echo "Storage rules have been deployed to Firebase."
    echo "Cart images should now be accessible."
    echo
else
    echo
    echo "========================================"
    echo "   Storage Rules Deployment Failed!"
    echo "========================================"
    echo
    echo "There was an error deploying storage rules."
    echo "Please check the error message above."
    echo
fi

echo
echo "Current storage rules:"
firebase storage:rules:get

echo

