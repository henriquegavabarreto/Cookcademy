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
}
