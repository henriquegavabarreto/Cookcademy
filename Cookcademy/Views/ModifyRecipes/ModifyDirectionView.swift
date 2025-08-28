//
//  ModifyDirectionView.swift
//  Cookcademy
//
//  Created by Henrique Barreto on 8/27/25.
//

import SwiftUI

struct ModifyDirectionView: View {
    @Binding var direction: Direction
    
    var body: some View {
        Form {
            TextField("Direction Description", text: $direction.description)
            Toggle("Optional", isOn: $direction.isOptional)
            HStack {
                Spacer()
                Button("Save") {
                    print("save direction")
                }
                Spacer()
            }
        }
    }
}

#Preview {
    @State var direction = Direction(description: "test", isOptional: true)
    return ModifyDirectionView(direction: $direction)
}
