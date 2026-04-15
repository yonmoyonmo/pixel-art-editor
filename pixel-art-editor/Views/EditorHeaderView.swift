import SwiftUI

struct EditorHeaderView: View {
    let columns: Int
    let rows: Int
    let exportAction: () -> Void

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Simple editor for transparent PNG output")
                    .font(.headline)
                Text("\(columns) x \(rows) canvas, touch or Apple Pencil to draw.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button("Export PNG", action: exportAction)
                .buttonStyle(.borderedProminent)
        }
    }
}
