import UIKit

enum PNGExporter {
    static func export(canvas: PixelCanvas) -> Data? {
        let size = CGSize(width: canvas.columns, height: canvas.rows)
        let rendererFormat = UIGraphicsImageRendererFormat()
        rendererFormat.scale = 1
        rendererFormat.opaque = false

        let renderer = UIGraphicsImageRenderer(size: size, format: rendererFormat)
        let image = renderer.image { context in
            UIColor.clear.setFill()
            context.fill(CGRect(origin: .zero, size: size))

            for row in 0..<canvas.rows {
                for column in 0..<canvas.columns {
                    guard let pixel = canvas[row, column] else { continue }
                    pixel.uiColor.setFill()
                    context.fill(CGRect(x: column, y: row, width: 1, height: 1))
                }
            }
        }

        return image.pngData()
    }
}
