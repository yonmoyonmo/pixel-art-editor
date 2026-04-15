import Combine
import CoreGraphics
import Foundation

@MainActor
final class EditorViewModel: ObservableObject {
    @Published private(set) var canvas = PixelCanvas()
    @Published var selectedColor: PixelColor = .default
    @Published var selectedTool: Tool = .brush
    @Published var isExporting = false
    @Published var exportDocument = PNGDocument(data: Data())
    @Published var exportName = "pixel-art.png"

    let palette = PixelColor.palette
    private var lastPaintedIndex: Int?

    func selectColor(_ color: PixelColor) {
        selectedColor = color
        selectedTool = .brush
    }

    func clearCanvas() {
        canvas.clear()
    }

    func beginExport() {
        guard let data = PNGExporter.export(canvas: canvas) else { return }
        exportDocument = PNGDocument(data: data)
        isExporting = true
    }

    func paint(at location: CGPoint, canvasSide: CGFloat) {
        guard let index = canvas.pixelIndex(at: location, canvasSide: canvasSide) else { return }
        guard lastPaintedIndex != index else { return }

        lastPaintedIndex = index
        let position = canvas.rowColumn(for: index)
        let color = selectedTool == .eraser ? nil : selectedColor.rgba
        canvas.paint(row: position.row, column: position.column, color: color)
    }

    func endStroke() {
        lastPaintedIndex = nil
    }
}
