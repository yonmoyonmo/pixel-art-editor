import Foundation

enum Tool: String, CaseIterable, Identifiable {
    case brush = "Brush"
    case eraser = "Eraser"

    var id: Self { self }
}
