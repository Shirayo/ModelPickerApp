//
//  ContentViewModel.swift
//  ModelPickerApp
//
//  Created by Vasili on 18.03.22.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    @Published var isPlacementEnabled = false
    @Published var selectedModel: Model?
    @Published var modelConfirmedForPlacement: Model?
    
}
