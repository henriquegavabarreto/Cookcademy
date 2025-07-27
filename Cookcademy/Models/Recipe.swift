//
//  Recipe.swift
//  Cookcademy
//
//  Created by Henrique Barreto on 7/27/25.
//

import Foundation

struct Recipe {
    var mainInformation: MainInformation
    var ingredients: [String]
    var directions: [String]
}

struct MainInformation {
    var name: String
    var description: String
    var author: String
    var category: Category
    
    // defines dish categories
    enum Category: String, CaseIterable {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
        case dessert = "Dessert"
    }
}
