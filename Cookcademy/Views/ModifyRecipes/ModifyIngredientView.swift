//
//  ModifyIngredientView.swift
//  Cookcademy
//
//  Created by Henrique Barreto on 8/19/25.
//

import SwiftUI

struct ModifyIngredientView: View {
    @Binding var ingredient: Ingredient
    let createAction: ((Ingredient) -> Void)
    
    // using dismiss instead of presentationMode because of deprecation
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Form {
                TextField("Ingredient Name", text: $ingredient.name)
                Stepper(value: $ingredient.quantity, in: 1...100, step: 0.5) {
                    // Create a label that shows current value and let user type value
                    HStack {
                        Text("Quantity:")
                        TextField("Quantity", value: $ingredient.quantity, formatter: NumberFormatter.decimal)
                            .keyboardType(.numbersAndPunctuation)
                    }
                }
                Picker("Unit", selection: $ingredient.unit) {
                    ForEach(Ingredient.Unit.allCases, id: \.self) { unit in
                        Text(unit.rawValue)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                HStack {
                    Spacer()
                    Button("Save") {
                        createAction(ingredient)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

// extend NumberFormatter to return a decimal formatter
extension NumberFormatter {
    static var decimal: NumberFormatter  {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
}

#Preview {
    @State var emptyIngredient = Ingredient(name: "", quantity: 1.0, unit: .none)
    return ModifyIngredientView(ingredient: $emptyIngredient) { ingredient in
        print(ingredient)
    }
}
