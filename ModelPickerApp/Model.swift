//
//  Model.swift
//  ModelPickerApp
//
//  Created by Vasili on 17.03.22.
//

import UIKit
import Combine
import RealityKit

class Model {    
    var name: String
    var Entity: ModelEntity?
    
    private var cancellable = Set<AnyCancellable>()
    
    init(modelName: String) {
        self.name = modelName
        let fileName = modelName + ".usdz"
        ModelEntity.loadModelAsync(named: fileName).sink { completion in
            print("oopsie doopsie")
        } receiveValue: { modelEntity in
            self.Entity = modelEntity
            print("DEBUG: successfully loaded modelEntity for modelName")
        }.store(in: &cancellable)

        
    }
    
}
