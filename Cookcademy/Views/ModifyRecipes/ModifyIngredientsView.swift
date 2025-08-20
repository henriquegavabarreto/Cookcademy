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
            if ingredients.isEmpty {
                Spacer()
                NavigationLink("Add the first ingredient", destination: ModifyIngredientView(ingredient: $newIngredient))
                Spacer()
            } else {
                List {
                    ForEach(ingredients.indices, id: \.self) { index in
                        let ingredient = ingredients[index]
                        Text(ingredient.description)
                        NavigationLink("Add another ingredient", destination: ModifyIngredientView(ingredient: $newIngredient))
                            .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
}

#Preview {
    @State var emptyIngredients = [Ingredient]()
    
    // wrap in a NavigationView for NavigationLink to work
    return NavigationView { ModifyIngredientsView(ingredients: $emptyIngredients) }
}
