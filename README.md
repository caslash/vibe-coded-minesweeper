# Minesweeper

A modern implementation of the classic Minesweeper game for iOS, built with SwiftUI.

## Features

- Three difficulty levels:
  - Beginner (8x8 grid, 10 mines)
  - Intermediate (16x16 grid, 40 mines)
  - Expert (24x24 grid, 99 mines)
- Tap to reveal cells
- Long press to flag potential mines
- Timer and mine counter
- Win/lose detection
- Clean, modern UI with support for light/dark mode

## Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+

## Installation

1. Clone the repository
2. Open `Minesweeper.xcodeproj` in Xcode
3. Build and run the project

## How to Play

1. Choose a difficulty level
2. Tap cells to reveal them
3. Long press to place/remove flags on suspected mine locations
4. Reveal all non-mine cells to win
5. Avoid revealing any mines

## Building and Running

Use the provided `buildandrun.sh` script to build and run the app on the iPhone 16 Pro Max simulator:
Edit the project directory path to match your setup.

```bash
./buildandrun.sh
```

## Architecture

The app follows the MVVM (Model-View-ViewModel) architecture:

- **Models**
  - `Cell`: Represents a single cell in the game board
  - `GameBoard`: Manages the game state and logic
- **Views**
  - `CellView`: Renders individual cells
  - `GameView`: Main game interface
- **ViewModels**
  - Game logic is handled by the `GameBoard` class

## License

This project is available under the MIT license. See the LICENSE file for more info.
