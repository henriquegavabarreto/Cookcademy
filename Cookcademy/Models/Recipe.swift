//
//  Recipe.swift
//  Cookcademy
//
//  Created by Henrique Barreto on 7/27/25.
//

import Foundation

struct Recipe {
    var mainInformation: MainInformation
    var ingredients: [Ingredient]
    var directions: [Direction]
    
    // creates recipe from given values
    init(mainInformation: MainInformation, ingredients: [Ingredient], directions: [Direction]) {
        self.mainInformation = mainInformation
        self.ingredients = ingredients
        self.directions = directions
    }
    
    // creates an empty recipe
    init() {
        self.init(mainInformation: MainInformation(name: "", description: "", author: "", category: .breakfast), ingredients: [], directions: [])
    }
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

struct Ingredient {
    var name: String
    var quantity: Double
    var unit: Unit
    
    var description: String {
        // get simpler readable number based on quantity
        let formattedQuantity = String(format: "%g", quantity)
        switch unit {
            case .none:
            // if there are no units, return number and ingredient name in singular or plural
                let formattedName = quantity == 1 ? name : "\(name)s"
                return "\(formattedQuantity) \(formattedName)"
            default:
            // for all other units, change unit string to plural when the quantity is not 1
                if quantity == 1 {
                    return "1 \(unit.singularName) \(name)"
                } else {
                    return "\(formattedQuantity) \(unit.rawValue) \(name)"
                }
        }
    }
    
    enum Unit: String, CaseIterable {
        case oz = "Ounces"
        case g = "Grams"
        case cups = "Cups"
        case tbs = "Tablespoons"
        case tsp = "Teaspoons"
        case none = "No units"
        
        // returns raw value without last letter (S)
        var singularName: String { String(rawValue.dropLast()) }
    }
}

struct Direction {
    var description: String
    var isOptional: Bool
}
