//
//  RecipeData.swift
//  Cookcademy
//
//  Created by Henrique Barreto on 7/28/25.
//

import Foundation

// Create RecipeData conforming to ObservableObject so @Published recipes changes can be tracked
class RecipeData: ObservableObject {
    @Published var recipes = Recipe.testRecipes
    
    // return a filtered recipes array based on given category
    func recipes(for category: MainInformation.Category) -> [Recipe] {
        var filteredRecipes = [Recipe]()
        for recipe in recipes {
            if recipe.mainInformation.category == category {
                filteredRecipes.append(recipe)
            }
        }
        
        return filteredRecipes
    }
    
    // add valid recipe to array
    func add(_ recipe: Recipe) {
        if recipe.isValid {
            recipes.append(recipe)
        }
    }
}
