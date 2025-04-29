import SwiftUI

struct GameView: View {
    @StateObject private var gameBoard = GameBoard()
    @State private var selectedDifficulty: Difficulty = .beginner
    
    private let cellSize: CGFloat = 30
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Mines: \(gameBoard.remainingMines)")
                    .font(.headline)
                
                Spacer()
                
                Text(String(format: "Time: %.0f", gameBoard.timeElapsed))
                    .font(.headline)
            }
            .padding()
            
            Picker("Difficulty", selection: $selectedDifficulty) {
                Text("Beginner").tag(Difficulty.beginner)
                Text("Intermediate").tag(Difficulty.intermediate)
                Text("Expert").tag(Difficulty.expert)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onChange(of: selectedDifficulty) { newValue in
                gameBoard.setDifficulty(newValue)
            }
            
            VStack(spacing: 0) {
                ForEach(0..<gameBoard.cells.count, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<gameBoard.cells[row].count, id: \.self) { column in
                            CellView(cell: gameBoard.cells[row][column], size: cellSize)
                                .onTapGesture {
                                    gameBoard.revealCell(at: (row, column))
                                }
                                .onLongPressGesture {
                                    gameBoard.toggleFlag(at: (row, column))
                                }
                        }
                    }
                }
            }
            .background(Color.gray.opacity(0.2))
            
            Button(action: {
                gameBoard.resetGame()
            }) {
                Text("New Game")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            
            if gameBoard.gameState == .won {
                Text("You Won! 🎉")
                    .font(.title)
                    .foregroundColor(.green)
            } else if gameBoard.gameState == .lost {
                Text("Game Over! 💥")
                    .font(.title)
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
} 