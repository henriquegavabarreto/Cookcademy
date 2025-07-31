//
//  ContentView.swift
//  Cookcademy
//
//  Created by Henrique Barreto on 7/25/25.
//

import SwiftUI

struct RecipesListView: View {
    // access RecipeData through the environment
    @EnvironmentObject private var recipeData: RecipeData
    let category: MainInformation.Category
    
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
    // get recipes for given category
    var recipes: [Recipe] { recipeData.recipes(for: category) }
    
    var navigationTitle: String { "\(category.rawValue) Recipes" }
}

#Preview {
    NavigationView {
        RecipesListView(category: .breakfast)
            .environmentObject(RecipeData())
    }
}
