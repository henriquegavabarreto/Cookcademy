//
//  ModifyIngredientView.swift
//  Cookcademy
//
//  Created by Henrique Barreto on 8/19/25.
//

import SwiftUI

// ModifyIngredient form
struct ModifyIngredientView: ModifyComponentView {
    @Binding var ingredient: Ingredient
    let createAction: ((Ingredient) -> Void)
    
    init(component: Binding<Ingredient>, createAction: @escaping (Ingredient) -> Void) {
        self._ingredient = component
        self.createAction = createAction
    }
    
    // using dismiss instead of presentationMode because of deprecation
    @Environment(\.dismiss) private var dismiss
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
            Form {
                TextField("Ingredient Name", text: $ingredient.name)
                    .listRowBackground(listBackgroundColor)
                Stepper(value: $ingredient.quantity, in: 1...100, step: 0.5) {
                    // Create a label that shows current value and let user type value
                    HStack {
                        Text("Quantity:")
                        TextField("Quantity", value: $ingredient.quantity, formatter: NumberFormatter.decimal)
                            .keyboardType(.numbersAndPunctuation)
                    }
                }
                .listRowBackground(listBackgroundColor)
                Picker("Unit", selection: $ingredient.unit) {
                    ForEach(Ingredient.Unit.allCases, id: \.self) { unit in
                        Text(unit.rawValue)
                    }
                }
                .listRowBackground(listBackgroundColor)
                .pickerStyle(MenuPickerStyle())
                HStack {
                    Spacer()
                    Button("Save") {
                        createAction(ingredient)
                        dismiss()
                    }
                    Spacer()
                }
                .listRowBackground(listBackgroundColor)
            }
            .foregroundStyle(listTextColor)
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
    @State var emptyIngredient = Ingredient()
    return ModifyIngredientView(component: $emptyIngredient) { ingredient in
        print(ingredient)
    }
}
