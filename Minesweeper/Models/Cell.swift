import Foundation
import SwiftUI

public struct Cell: Identifiable {
    public let id = UUID()
    public var isRevealed: Bool = false
    public var isMine: Bool = false
    public var isFlagged: Bool = false
    public var adjacentMines: Int = 0
    
    public var displayText: String {
        if isFlagged {
            return "🚩"
        }
        if !isRevealed {
            return ""
        }
        if isMine {
            return "💣"
        }
        return adjacentMines == 0 ? "" : "\(adjacentMines)"
    }
    
    public var backgroundColor: Color {
        if !isRevealed {
            return .gray.opacity(0.3)
        }
        if isMine {
            return .red
        }
        return .white
    }
    
    public var textColor: Color {
        if !isRevealed {
            return .clear
        }
        if isMine {
            return .white
        }
        switch adjacentMines {
        case 1: return .blue
        case 2: return .green
        case 3: return .red
        case 4: return .purple
        case 5: return .orange
        case 6: return .teal
        case 7: return .black
        case 8: return .gray
        default: return .clear
        }
    }
    
    public init() {}
} 