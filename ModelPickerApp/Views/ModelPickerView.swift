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
    @Environment(\.presentationMode) var presentationMode
    var models: [Model]
    
    var body: some View {
        GeometryReader { proxy in
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: proxy.size.width / 2 - 8, maximum: 600), spacing: 0),
            ], spacing: 0, content: {
                ForEach(models, id: \.name) { model in
                    Button {
                        isPlacementEnabled = true
                        selectedModel = model

                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(model.name)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .background(.clear)
                            .cornerRadius(12)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                }
            })
        }
        .background(BackgroundClearView())
    }
}



//struct ModelPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        ModelPickerView()
//    }
//}
