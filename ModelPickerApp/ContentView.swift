//
//  ContentView.swift
//  ModelPickerApp
//
//  Created by Vasili on 17.03.22.
//

import SwiftUI
import RealityKit
import FocusEntity
import Combine
import ARKit

struct ContentView : View {
    
    @State private var isPlacementEnabled = false
//    @State private var selectedModel: Model?
    @State private var isSettingsOpen = false
    @State private var modelConfirmedForPlacement: Model?
    
    @ObservedObject private var vm: ContentViewModel = .init()
    
    private var models: [Model] = {
        let fileManager = FileManager.default
        guard let path = Bundle.main.resourcePath, let files = try? fileManager.contentsOfDirectory(atPath: path) else {
            return []
        }
        var availableModels: [Model] = []
        for file in files where file.hasSuffix("usdz") {
            let modelName = file.replacingOccurrences(of: ".usdz", with: "")
            availableModels.append(Model(modelName: modelName))
        }
        return availableModels
    }()
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            ARViewContainer(modelConfirmedForPlacement: $modelConfirmedForPlacement)
                .ignoresSafeArea()
            HStack(alignment: .bottom) {
                Spacer()
                Button {
                    isSettingsOpen = true
                } label: {
                    Image(systemName: "folder.badge.gearshape")
                        .frame(width: 60, height: 60)
                        .background(.white.opacity(0.75))
                        .foregroundColor(.black)
                        .cornerRadius(30)
                        .padding(20)
                }
            }
            if vm.isPlacementEnabled {
                PlacementButtonsView(isPlacementEnabled: $vm.isPlacementEnabled, selectedModel: $vm.selectedModel, modelConfirmedForPlacement: $modelConfirmedForPlacement)
            }
        }
        .sheet(isPresented: $isSettingsOpen) {
            print(isSettingsOpen)
        } content: {
            ZStack {
                Color.black.opacity(0.1)
                    .ignoresSafeArea()
                    .background(.ultraThinMaterial)

                ModelPickerView(isPlacementEnabled: $vm.isPlacementEnabled, selectedModel: $vm.selectedModel, models: models)
            }
        }

    }

}
    
struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
            
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}


#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13 Pro")
    }
}
#endif
