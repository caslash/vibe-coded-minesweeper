# Minesweepre – Technical Specification

## Overview

**Project Name:** Minesweepre  
**Platform:** iOS (iPhone and iPad)  
**Tech Stack:** Swift, SwiftUI, Combine, XCTest

Minesweepre is a modern interpretation of the classic Minesweeper game, developed using Swift and SwiftUI. It will support a clean, responsive design with support for light/dark modes, haptics, and accessibility features.

---

## Features

### Core Gameplay

- Configurable grid sizes: 8x8 (Beginner), 16x16 (Intermediate), 24x24 (Expert)
- Random mine placement with reproducible seed for debugging
- Tap to reveal cells, long press to flag
- Recursive clearing of empty spaces
- Game over and win conditions
- Timer and mine counter

### UX/UI

- SwiftUI adaptive layout
- Haptic feedback for taps and game state changes
- Light and Dark Mode support
- Animations for cell reveal, flag placement, and explosions
- Accessibility: VoiceOver, dynamic text sizing

### Game States

- NotStarted, Playing, Won, Lost
- Restart functionality
- Track high scores and personal best times

---

## Architecture

### MVVM Structure

- **Model**
  - `Cell`: struct representing each cell's state (isRevealed, isMine, isFlagged, adjacentMines)
  - `GameBoard`: handles grid generation, mine placement, game logic
- **ViewModel**
  - `GameViewModel`: exposes state to the View, processes user actions
- **View**
  - `GameView`: renders the board
  - `CellView`: individual cell rendering
  - `HUDView`: mine count, timer, restart button

### Data Handling

- Store best times per difficulty using `UserDefaults`
- Optional: Add shareable seed logic for repeating puzzles

---

## Animations and Feedback

- Use `withAnimation` for smooth cell reveals and transitions
- Use `UIImpactFeedbackGenerator` for light, medium, and heavy haptics

---

## Testing

### Unit Tests

Use XCTest to test:

- Board initialization (correct number of mines, placement validity)
- Cell reveal logic (recursive revealing, boundary conditions)
- Flag toggle logic
- Game state transitions

### UI Tests (Optional)

- Tap and long-press gestures on board
- Win/loss detection

---

## Milestones

1. Board model and mine placement logic
2. Game state and view model integration
3. SwiftUI view rendering
4. Gesture and interaction support
5. Win/loss logic and feedback
6. Persistence (high scores)
7. Testing and QA
8. Polishing UI/UX (animations, haptics, accessibility)

---

## Dependencies

- SwiftUI (native)
- Combine (state management)
- XCTest (unit testing)
- Optional: Swift Package for animations or analytics (e.g., Lottie, Firebase)
