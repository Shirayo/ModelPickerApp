//
//  PlacementButtonsView.swift
//  ModelPickerApp
//
//  Created by Vasili on 17.03.22.
//

import SwiftUI

struct PlacementButtonsView: View {
        
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: Model?
    @Binding var modelConfirmedForPlacement: Model?
    
    var body: some View {
        HStack {
            Button {
                resetPlacementParameters()
            } label: {
                Image(systemName: "xmark")
                    .frame(width: 60, height: 60)
                    .background(.white.opacity(0.75))
                    .cornerRadius(30)

                    .padding(20)
            }
            Button {
                self.modelConfirmedForPlacement = nil
                self.modelConfirmedForPlacement = self.selectedModel
                resetPlacementParameters()
            } label: {
                Image(systemName: "checkmark")
                    .frame(width: 60, height: 60)
                    .background(.white.opacity(0.75))
                    .cornerRadius(30)

                    .padding(20)
            }
        }.font(.title)
    }
    func resetPlacementParameters() {
        self.isPlacementEnabled = false
        self.selectedModel = nil
    }
}


//struct PlacementButtonsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlacementButtonsView()
//    }
//}
