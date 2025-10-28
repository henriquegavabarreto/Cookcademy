//
//  MainTabView.swift
//  Cookcademy
//
//  Created by Henrique Barreto on 10/28/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        @StateObject var recipeData = RecipeData()
        TabView {
            RecipeCategoryGridView()
                .tabItem { Label("Recipes", systemImage: "list.dash") }
            NavigationView {
                RecipesListView(category: .breakfast)
            }
            .tabItem { Label("Favorites", systemImage: "heart.fill") }
        }
        .environmentObject(recipeData)
    }
}

#Preview {
    MainTabView()
}
