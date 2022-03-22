//
//  CustomGridCell.swift
//  ModelPickerApp
//
//  Created by Shirayo on 22.03.2022.
//

import SwiftUI

struct CustomGridCell: View {
    
//    @Binding var isModelLoading: Bool
    
    var body: some View {
        ZStack {
            Image(systemName: "checkmark")
                .resizable()
                .frame(width: 80, height: 80)
//            if isModelLoading {
//                ZStack {
//                    Color.black.opacity(0.5)
//                        .background(.thinMaterial)
//                }
//            }
        }
    }
}

struct CustomGridCell_Previews: PreviewProvider {
    static var previews: some View {
        CustomGridCell()
    }
}
