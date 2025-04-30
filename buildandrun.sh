#!/bin/bash

# Build and run the Minesweeper app on iPhone 16 Pro Max simulator
echo "Building and running Minesweeper..."

# Boot the simulator if not already booted
echo "Ensuring simulator is booted..."
xcrun simctl boot "iPhone 16 Pro Max" || true
open -a Simulator

# Wait for simulator to finish booting
echo "Waiting for simulator to boot..."
sleep 5

# Build the app
xcodebuild -scheme Minesweeper -destination "platform=iOS Simulator,name=iPhone 16 Pro Max,OS=18.4" build

# Install the app
echo "Installing the app..."
xcrun simctl install booted "~/Library/Developer/Xcode/DerivedData/Minesweeper-baokmktfpdukxcedtueuveqrhxog/Build/Products/Debug-iphonesimulator/Minesweeper.app"

# Launch the app
echo "Launching the app..."
xcrun simctl launch booted com.example.Minesweeper

echo "Done!" 