//
//  ARViewContainer.swift
//  ModelPickerApp
//
//  Created by Vasili on 18.03.22.
//

import SwiftUI
import ARKit
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    
    @Binding var modelConfirmedForPlacement: Model?
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = CustomARView(frame: .zero)
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
                
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        arView.session.run(config)
        
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = arView.session
        coachingOverlay.goal = .horizontalPlane
        arView.addSubview(coachingOverlay)
        
        
//        arView.debugOptions = [.showFeaturePoints]

        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        if let model = modelConfirmedForPlacement {
            if let modelEntity = model.Entity {
                let anchorEntity = AnchorEntity(plain: .any)
                anchorEntity.addChild(modelEntity)
                uiView.scene.addAnchor(anchorEntity.clone(recursive: true))
            } else {
                //error handling...
            }
        }
    }
    
}
