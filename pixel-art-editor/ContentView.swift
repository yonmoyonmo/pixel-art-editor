//
//  ContentView.swift
//  pixel-art-editor
//
//  Created by yonmo on 4/14/26.
//

import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @StateObject private var viewModel = EditorViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                EditorHeaderView(
                    columns: viewModel.canvas.columns,
                    rows: viewModel.canvas.rows,
                    exportAction: viewModel.beginExport
                )

                PixelCanvasView(
                    canvas: viewModel.canvas,
                    paintAction: viewModel.paint,
                    endStrokeAction: viewModel.endStroke
                )

                EditorControlsView(
                    palette: viewModel.palette,
                    selectedColor: viewModel.selectedColor,
                    selectedTool: viewModel.selectedTool,
                    toolChanged: { viewModel.selectedTool = $0 },
                    colorSelected: viewModel.selectColor,
                    clearAction: viewModel.clearCanvas
                )
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Pixel Art")
            .fileExporter(
                isPresented: $viewModel.isExporting,
                document: viewModel.exportDocument,
                contentType: .png,
                defaultFilename: viewModel.exportName
            ) { _ in }
        }
    }
}
