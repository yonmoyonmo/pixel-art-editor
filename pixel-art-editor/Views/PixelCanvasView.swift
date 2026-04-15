import SwiftUI

struct PixelCanvasView: View {
    let canvas: PixelCanvas
    let paintAction: (CGPoint, CGFloat) -> Void
    let endStrokeAction: () -> Void

    var body: some View {
        GeometryReader { proxy in
            let side = min(proxy.size.width, proxy.size.height)

            ZStack {
                CheckerboardView()

                Canvas { context, size in
                    let cellWidth = size.width / CGFloat(canvas.columns)
                    let cellHeight = size.height / CGFloat(canvas.rows)

                    for row in 0..<canvas.rows {
                        for column in 0..<canvas.columns {
                            let rect = CGRect(
                                x: CGFloat(column) * cellWidth,
                                y: CGFloat(row) * cellHeight,
                                width: cellWidth,
                                height: cellHeight
                            )

                            if let pixel = canvas[row, column] {
                                context.fill(Path(rect), with: .color(pixel.swiftUIColor))
                            }

                            context.stroke(
                                Path(rect),
                                with: .color(Color.black.opacity(0.12)),
                                lineWidth: 0.5
                            )
                        }
                    }
                }
            }
            .frame(width: side, height: side)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(Color.black.opacity(0.18), lineWidth: 1)
            }
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        paintAction(value.location, side)
                    }
                    .onEnded { _ in
                        endStrokeAction()
                    }
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxHeight: 520)
    }
}

private struct CheckerboardView: View {
    var body: some View {
        Canvas { context, size in
            let square = max(size.width / 8, 12)
            let columns = Int(ceil(size.width / square))
            let rows = Int(ceil(size.height / square))

            for row in 0..<rows {
                for column in 0..<columns {
                    let rect = CGRect(
                        x: CGFloat(column) * square,
                        y: CGFloat(row) * square,
                        width: square,
                        height: square
                    )
                    let fill = (row + column).isMultiple(of: 2)
                        ? Color.white
                        : Color(.systemGray5)
                    context.fill(Path(rect), with: .color(fill))
                }
            }
        }
    }
}
