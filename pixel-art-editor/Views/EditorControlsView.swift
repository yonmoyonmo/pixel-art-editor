import SwiftUI

struct EditorControlsView: View {
    let palette: [PixelColor]
    let selectedColor: PixelColor
    let selectedTool: Tool
    let toolChanged: (Tool) -> Void
    let colorSelected: (PixelColor) -> Void
    let clearAction: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Picker("Tool", selection: Binding(get: {
                selectedTool
            }, set: { toolChanged($0) })) {
                ForEach(Tool.allCases) { tool in
                    Text(tool.rawValue).tag(tool)
                }
            }
            .pickerStyle(.segmented)

            VStack(alignment: .leading, spacing: 10) {
                Text("Palette")
                    .font(.headline)

                HStack(spacing: 12) {
                    ForEach(palette) { item in
                        Button {
                            colorSelected(item)
                        } label: {
                            Circle()
                                .fill(item.color)
                                .frame(width: 34, height: 34)
                                .overlay {
                                    Circle()
                                        .stroke(
                                            selectedColor == item ? Color.primary : Color.black.opacity(0.15),
                                            lineWidth: selectedColor == item ? 3 : 1
                                        )
                                }
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel(item.name)
                    }
                }
            }

            HStack {
                Text(selectedTool == .eraser ? "Transparent pixel" : "Current color")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Spacer()

                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(selectedTool == .eraser ? .clear : selectedColor.color)
                    .frame(width: 42, height: 42)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color.white)
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(Color.black.opacity(0.15), lineWidth: 1)
                    }
            }

            Button("Clear Canvas", action: clearAction)
                .buttonStyle(.bordered)
        }
        .padding(18)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}
