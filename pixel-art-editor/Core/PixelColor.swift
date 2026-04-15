import SwiftUI
import UIKit

struct PixelColor: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let color: Color
    let rgba: RGBAColor

    static let `default` = palette[0]

    static let palette: [PixelColor] = [
        PixelColor(name: "Ink", color: .black, rgba: .init(red: 0.08, green: 0.08, blue: 0.1, alpha: 1)),
        PixelColor(name: "Snow", color: .white, rgba: .init(red: 1, green: 1, blue: 1, alpha: 1)),
        PixelColor(name: "Coral", color: .red, rgba: .init(red: 0.91, green: 0.39, blue: 0.34, alpha: 1)),
        PixelColor(name: "Gold", color: .yellow, rgba: .init(red: 0.96, green: 0.76, blue: 0.24, alpha: 1)),
        PixelColor(name: "Mint", color: .green, rgba: .init(red: 0.36, green: 0.78, blue: 0.56, alpha: 1)),
        PixelColor(name: "Sky", color: .blue, rgba: .init(red: 0.32, green: 0.57, blue: 0.97, alpha: 1)),
        PixelColor(name: "Violet", color: .purple, rgba: .init(red: 0.57, green: 0.42, blue: 0.87, alpha: 1))
    ]
}

struct RGBAColor: Equatable {
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    let alpha: CGFloat

    var swiftUIColor: Color {
        Color(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }

    var uiColor: UIColor {
        UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
