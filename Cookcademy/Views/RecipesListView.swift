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
    
    var body: some View {
        List {
            ForEach(recipeData.recipes) { recipe in
                Text(recipe.mainInformation.name)
            }
        }
        .navigationTitle("All Recipes")
    }
}

#Preview {
    NavigationView {
        RecipesListView()
    }
}
