//
//  ContentView.swift
//  Cookcademy
//
//  Created by Henrique Barreto on 7/25/25.
//

import SwiftUI

struct RecipesListView: View {
    // declare recipeData with @StateObject wrapper, so the view updates when the model changes
    @StateObject var recipeData = RecipeData()
    
    // declare list colors
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        List {
            ForEach(recipes) { recipe in
                NavigationLink(recipe.mainInformation.name, destination: RecipeDetailView(recipe: recipe))
            }
            .listRowBackground(listBackgroundColor)
            .foregroundStyle(listTextColor) // Using foregroundStyle, as foregroundColor is deprecated
        }
        .navigationTitle(navigationTitle)
    }
}

// add computed properties to improve readability and maintainability
extension RecipesListView {
    var recipes: [Recipe] { recipeData.recipes }
    
    var navigationTitle: String { "All Recipes" }
}

#Preview {
    NavigationView {
        RecipesListView()
    }
}
