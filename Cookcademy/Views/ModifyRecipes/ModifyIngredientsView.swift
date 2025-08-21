//
//  ModifyIngredientsView.swift
//  Cookcademy
//
//  Created by Henrique Barreto on 8/20/25.
//

import SwiftUI

struct ModifyIngredientsView: View {
    @Binding var ingredients: [Ingredient]
    @State private var newIngredient = Ingredient(name: "", quantity: 0.0, unit: .none)
    
    var body: some View {
        VStack {
            let addIngredientView = ModifyIngredientView(ingredient: $newIngredient) { ingredient in
                ingredients.append(ingredient)
                newIngredient = Ingredient(name: "", quantity: 0.0, unit: .none)
            }
            if ingredients.isEmpty {
                Spacer()
                NavigationLink("Add the first ingredient", destination: addIngredientView)
                Spacer()
            } else {
                List {
                    ForEach(ingredients.indices, id: \.self) { index in
                        let ingredient = ingredients[index]
                        Text(ingredient.description)
                    }
                    NavigationLink("Add another ingredient", destination: addIngredientView)
                        .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

#Preview {
    @State var emptyIngredients = [Ingredient]()
    
    return NavigationView { ModifyIngredientsView(ingredients: $emptyIngredients)}
}
