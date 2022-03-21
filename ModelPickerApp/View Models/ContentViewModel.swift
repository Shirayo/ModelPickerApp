//
//  ContentViewModel.swift
//  ModelPickerApp
//
//  Created by Vasili on 18.03.22.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    
    @Published var isPlacementEnabled = false
    @Published var selectedModel: Model? = nil
 
}
