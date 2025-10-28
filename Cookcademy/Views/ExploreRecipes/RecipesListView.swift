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
    
    // viewStyle - MainInformation category or favorite recipes
    let viewStyle: ViewStyle
    
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
                NavigationLink(recipe.mainInformation.name, destination: RecipeDetailView(recipe: binding(for: recipe)))
            }
            .listRowBackground(listBackgroundColor)
            .foregroundStyle(listTextColor) // Using foregroundStyle, as foregroundColor is deprecated
        }
        .navigationTitle(navigationTitle)
        .toolbar {
            // adds button to top right
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    newRecipe = Recipe()
                    // add default category information to recipe
                    newRecipe.mainInformation.category = recipes.first?.mainInformation.category ?? .breakfast
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
                                    // make recipe a favorite when added from favorites tab
                                    if case .favorites = viewStyle {
                                        newRecipe.isFavorite = true
                                    }
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
    enum ViewStyle {
        case favorites
        case singleCategory(MainInformation.Category)
    }
    
    // get recipes for given category or favorite recipes
    var recipes: [Recipe] {
        switch viewStyle {
        case let .singleCategory(category):
            return recipeData.recipes(for: category)
        case .favorites:
            return recipeData.favoriteRecipes
        }
    }
    
    // return navigation title based on viewStyle - category or favotites
    var navigationTitle: String {
        switch viewStyle {
        case let .singleCategory(category):
            return "\(category.rawValue) Recipes"
        case .favorites:
            return "Favorite Recipes"
        }
    }
    
    // returns binding of a recipe for a given recipe so modifications can be made
    // using the forms
    func binding(for recipe: Recipe) -> Binding<Recipe> {
        // get index of recipe
        guard let index = recipeData.index(of: recipe) else {
            fatalError("Recipe not found")
        }
        // return binding of the recipe
        return $recipeData.recipes[index]
    }
}

#Preview {
    NavigationView {
        RecipesListView(viewStyle: .singleCategory(.breakfast))
            .environmentObject(RecipeData())
    }
}
