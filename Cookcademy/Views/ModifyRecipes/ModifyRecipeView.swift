//
//  ModifyRecipeView.swift
//  Cookcademy
//
//  Created by Henrique Barreto on 7/31/25.
//

import SwiftUI

struct ModifyRecipeView: View {
    // recieves a recipe do be modified
    @Binding var recipe: Recipe
    
    var body: some View {
        // fills recipe with mock data through binding
        Button("Fill in the recipe with test data.") {
            recipe.mainInformation = MainInformation(name: "test",
                                                     description: "test",
                                                     author: "test",
                                                     category: .breakfast)
            recipe.directions = [Direction(description: "test",
                                           isOptional: false)]
            recipe.ingredients = [Ingredient(name: "test",
                                             quantity: 1.0,
                                             unit: .none)]
        }
    }
}

#Preview {
    @State var recipe = Recipe()
    
    return ModifyRecipeView(recipe: $recipe)
}
