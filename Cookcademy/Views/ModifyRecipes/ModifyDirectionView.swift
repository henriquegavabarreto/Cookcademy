//
//  ModifyDirectionView.swift
//  Cookcademy
//
//  Created by Henrique Barreto on 8/27/25.
//

import SwiftUI

struct ModifyDirectionView: View {
    @Binding var direction: Direction
    let createAction: (Direction) -> Void
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
    @State var direction = Direction(description: "test", isOptional: true)
    let action: (Direction) -> Void = { direction in
        print(direction)
    }
    return ModifyDirectionView(direction: $direction, createAction: action)
}
