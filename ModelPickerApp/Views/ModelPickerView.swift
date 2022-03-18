//
//  ModelPickerView.swift
//  ModelPickerApp
//
//  Created by Vasili on 17.03.22.
//

import SwiftUI

struct ModelPickerView: View {
    
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: Model?

    var models: [Model]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(models, id: \.name) { model in
                    Button {
                        isPlacementEnabled = true
                        selectedModel = model
                    } label: {
                        Image(model.name)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .background(.white)
                            .cornerRadius(12)
                    }
                    .buttonStyle(PlainButtonStyle())

                }
            }
        }
    }
}

//struct ModelPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        ModelPickerView()
//    }
//}
