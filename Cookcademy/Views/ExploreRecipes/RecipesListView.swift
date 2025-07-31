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
    
    // bool that controls sheet presenting status
    @State private var isPresenting = false
    // new recipe value to be bound to ModifyRecipeView
    @State private var newRecipe = Recipe()
    
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
        .toolbar {
            // adds button to top right
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isPresenting = true
                }, label: {
                    Image(systemName: "plus")
                })
            }
        }
        .sheet(isPresented: $isPresenting) {
            NavigationView {
                ModifyRecipeView(recipe: $newRecipe)
                    .navigationTitle("Add a New Recipe")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresenting = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            if newRecipe.isValid {
                                Button("Add") {
                                    recipeData.add(newRecipe)
                                    isPresenting = false
                                }
                            }
                        }
                    }
            }
        }
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
