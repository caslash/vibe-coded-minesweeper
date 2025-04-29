import SwiftUI

struct CellView: View {
    let cell: Cell
    let size: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(cell.backgroundColor)
                .frame(width: size, height: size)
                .border(Color.gray, width: 1)
            
            Text(cell.displayText)
                .font(.system(size: size * 0.6))
                .foregroundColor(cell.textColor)
        }
    }
} 