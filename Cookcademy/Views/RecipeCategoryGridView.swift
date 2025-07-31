//
//  RecipeCategoryGridView.swift
//  Cookcademy
//
//  Created by Henrique Barreto on 7/30/25.
//

import SwiftUI

struct RecipeCategoryGridView: View {
    // declare the RecipeData ViewModel
    @StateObject private var recipeData = RecipeData()
    
    var body: some View {
        let columns = [GridItem(), GridItem()]
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(MainInformation.Category.allCases, id: \.self) { category in
                        NavigationLink(destination: RecipesListView(category: category).environmentObject(recipeData), label: {
                            CategoryView(category: category)
                        })
                    }
                }
            }
            .navigationTitle("Categories")
        }
    }
}

struct CategoryView: View {
    let category: MainInformation.Category
    
    var body: some View {
        ZStack {
            Image(category.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.35)
            Text(category.rawValue)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    RecipeCategoryGridView()
}
