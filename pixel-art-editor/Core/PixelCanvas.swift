import CoreGraphics

struct PixelCanvas {
    let columns: Int
    let rows: Int
    private(set) var pixels: [RGBAColor?]

    init(columns: Int = 32, rows: Int = 32, pixels: [RGBAColor?]? = nil) {
        self.columns = columns
        self.rows = rows
        self.pixels = pixels ?? Array(repeating: nil, count: columns * rows)
    }

    subscript(row: Int, column: Int) -> RGBAColor? {
        get { pixels[row * columns + column] }
        set { pixels[row * columns + column] = newValue }
    }

    mutating func clear() {
        pixels = Array(repeating: nil, count: columns * rows)
    }

    mutating func paint(row: Int, column: Int, color: RGBAColor?) {
        let index = row * columns + column
        pixels[index] = color
    }

    func pixelIndex(at location: CGPoint, canvasSide: CGFloat) -> Int? {
        guard canvasSide > 0 else { return nil }
        let cellWidth = canvasSide / CGFloat(columns)
        let cellHeight = canvasSide / CGFloat(rows)
        let column = min(max(Int(location.x / cellWidth), 0), columns - 1)
        let row = min(max(Int(location.y / cellHeight), 0), rows - 1)
        return row * columns + column
    }

    func rowColumn(for index: Int) -> (row: Int, column: Int) {
        (row: index / columns, column: index % columns)
    }
}
