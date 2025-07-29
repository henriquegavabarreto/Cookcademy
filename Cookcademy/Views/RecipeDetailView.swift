//
//  RecipeDetailView.swift
//  Cookcademy
//
//  Created by Henrique Barreto on 7/28/25.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
    // declare list colors
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
            // recipe's author
            HStack {
                Text("Author: \(recipe.mainInformation.author)")
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            // recipe's description
            HStack {
                Text(recipe.mainInformation.description)
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            List {
                // recipe's ingredients
                Section(header: Text("Ingredients")) {
                    ForEach(recipe.ingredients.indices, id: \.self) { index in
                        let ingredient = recipe.ingredients[index]
                        Text(ingredient.description)
                            .foregroundStyle(listTextColor)
                    }
                    .listRowBackground(listBackgroundColor)
                }
                // recipe's directions
                Section(header: Text("Directions")) {
                    ForEach(recipe.directions.indices, id: \.self) { index in
                        let direction = recipe.directions[index]
                        HStack {
                            // step number
                            Text("\(index + 1).").bold()
                            // optional status followed by direction description
                            Text("\(direction.isOptional ? "Optional" : "")" + "\(direction.description)")
                        }
                        .foregroundStyle(listTextColor)
                    }
                    .listRowBackground(listBackgroundColor)
                }
            }
        }
        .navigationTitle(recipe.mainInformation.name)
    }
}

#Preview {
    @State var recipe = Recipe.testRecipes[0]
    return NavigationView {
        RecipeDetailView(recipe: recipe)
    }
}
