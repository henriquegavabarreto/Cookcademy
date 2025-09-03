//
//  ModifyDirectionView.swift
//  Cookcademy
//
//  Created by Henrique Barreto on 8/27/25.
//

import SwiftUI

// ModifyDirection form
struct ModifyDirectionView: ModifyComponentView {
    @Binding var direction: Direction
    let createAction: (Direction) -> Void
    
    init(component: Binding<Direction>, createAction: @escaping (Direction) -> Void) {
        self._direction = component
        self.createAction = createAction
    }
    
    @Environment(\.dismiss) var dismiss
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        Form {
            TextField("Direction Description", text: $direction.description)
                .listRowBackground(listBackgroundColor)
            Toggle("Optional", isOn: $direction.isOptional)
                .listRowBackground(listBackgroundColor)
            HStack {
                Spacer()
                Button("Save") {
                    createAction(direction)
                    dismiss()
                }
                Spacer()
            }
            .listRowBackground(listBackgroundColor)
        }
        .foregroundStyle(listTextColor)
    }
}

#Preview {
    @State var direction = Direction()
    return ModifyDirectionView(component: $direction) { direction in
        print(direction)
    }
}
