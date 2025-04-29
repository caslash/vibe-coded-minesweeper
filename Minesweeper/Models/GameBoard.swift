import Foundation
import SwiftUI

public enum GameState {
    case notStarted
    case playing
    case won
    case lost
}

public enum Difficulty {
    case beginner
    case intermediate
    case expert
    
    public var gridSize: (rows: Int, columns: Int) {
        switch self {
        case .beginner: return (8, 8)
        case .intermediate: return (16, 16)
        case .expert: return (24, 24)
        }
    }
    
    public var mineCount: Int {
        switch self {
        case .beginner: return 10
        case .intermediate: return 40
        case .expert: return 99
        }
    }
}

public class GameBoard: ObservableObject {
    @Published public var cells: [[Cell]] = []
    @Published public var gameState: GameState = .notStarted
    @Published public var remainingMines: Int = 0
    @Published public var timeElapsed: TimeInterval = 0
    
    private var difficulty: Difficulty
    private var timer: Timer?
    private var firstMove: Bool = true
    
    public init(difficulty: Difficulty = .beginner) {
        self.difficulty = difficulty
        self.remainingMines = difficulty.mineCount
        initializeBoard()
    }
    
    private func initializeBoard() {
        let (rows, columns) = difficulty.gridSize
        cells = Array(repeating: Array(repeating: Cell(), count: columns), count: rows)
    }
    
    private func placeMines(excluding position: (row: Int, column: Int)) {
        var minesPlaced = 0
        let (rows, columns) = difficulty.gridSize
        
        while minesPlaced < difficulty.mineCount {
            let row = Int.random(in: 0..<rows)
            let column = Int.random(in: 0..<columns)
            
            // Don't place mine on first clicked cell or if there's already a mine
            if (row != position.row || column != position.column) && !cells[row][column].isMine {
                cells[row][column].isMine = true
                minesPlaced += 1
            }
        }
        
        calculateAdjacentMines()
    }
    
    private func calculateAdjacentMines() {
        let (rows, columns) = difficulty.gridSize
        
        for row in 0..<rows {
            for column in 0..<columns {
                if !cells[row][column].isMine {
                    var count = 0
                    
                    // Check all 8 adjacent cells
                    for r in max(0, row-1)...min(rows-1, row+1) {
                        for c in max(0, column-1)...min(columns-1, column+1) {
                            if cells[r][c].isMine {
                                count += 1
                            }
                        }
                    }
                    
                    cells[row][column].adjacentMines = count
                }
            }
        }
    }
    
    public func revealCell(at position: (row: Int, column: Int)) {
        guard gameState == .notStarted || gameState == .playing else { return }
        
        if firstMove {
            firstMove = false
            placeMines(excluding: position)
            startTimer()
            gameState = .playing
        }
        
        let (row, column) = position
        guard row >= 0 && row < cells.count && column >= 0 && column < cells[0].count else { return }
        
        var cell = cells[row][column]
        guard !cell.isRevealed && !cell.isFlagged else { return }
        
        cell.isRevealed = true
        cells[row][column] = cell
        
        if cell.isMine {
            gameOver()
            return
        }
        
        if cell.adjacentMines == 0 {
            // Recursively reveal adjacent cells
            for r in max(0, row-1)...min(cells.count-1, row+1) {
                for c in max(0, column-1)...min(cells[0].count-1, column+1) {
                    if !cells[r][c].isRevealed {
                        revealCell(at: (r, c))
                    }
                }
            }
        }
        
        checkWinCondition()
    }
    
    public func toggleFlag(at position: (row: Int, column: Int)) {
        guard gameState == .playing else { return }
        
        let (row, column) = position
        guard row >= 0 && row < cells.count && column >= 0 && column < cells[0].count else { return }
        
        var cell = cells[row][column]
        guard !cell.isRevealed else { return }
        
        cell.isFlagged.toggle()
        cells[row][column] = cell
        
        remainingMines += cell.isFlagged ? -1 : 1
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.timeElapsed += 1
        }
    }
    
    private func gameOver() {
        timer?.invalidate()
        timer = nil
        gameState = .lost
        
        // Reveal all mines
        for row in 0..<cells.count {
            for column in 0..<cells[0].count {
                if cells[row][column].isMine {
                    var cell = cells[row][column]
                    cell.isRevealed = true
                    cells[row][column] = cell
                }
            }
        }
    }
    
    private func checkWinCondition() {
        let unrevealedCount = cells.flatMap { $0 }.filter { !$0.isRevealed }.count
        if unrevealedCount == difficulty.mineCount {
            timer?.invalidate()
            timer = nil
            gameState = .won
        }
    }
    
    public func resetGame() {
        timer?.invalidate()
        timer = nil
        gameState = .notStarted
        remainingMines = difficulty.mineCount
        timeElapsed = 0
        firstMove = true
        initializeBoard()
    }
    
    public func setDifficulty(_ newDifficulty: Difficulty) {
        difficulty = newDifficulty
        resetGame()
    }
} 