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
    
    var body: some View {
        Form {
            TextField("Direction Description", text: $direction.description)
            Toggle("Optional", isOn: $direction.isOptional)
            HStack {
                Spacer()
                Button("Save") {
                    createAction(direction)
                    dismiss()
                }
                Spacer()
            }
        }
    }
}

#Preview {
    @State var direction = Direction(description: "test", isOptional: true)
    let action: (Direction) -> Void = { direction in
        print(direction)
    }
    return ModifyDirectionView(direction: $direction, createAction: action)
}
