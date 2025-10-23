//
//  ModifyIngredientsView.swift
//  Cookcademy
//
//  Created by Henrique Barreto on 8/20/25.
//

import SwiftUI

protocol RecipeComponent: CustomStringConvertible {
    static func singularName() -> String
    static func pluralName() -> String
    init()
}

extension RecipeComponent {
    static func singularName() -> String {
        String(describing: self).lowercased()
    }
    
    static func pluralName() -> String {
        self.singularName() + "s"
    }
}

protocol ModifyComponentView: View {
    associatedtype Component
    init(component: Binding<Component>, createAction: @escaping (Component) -> Void)
}

// Shows a list of RecipeComponents and make it possible to add these components to the list
struct ModifyComponentsView<Component: RecipeComponent, DestinationView: ModifyComponentView>: View where DestinationView.Component == Component {
    // list of components from a recipe
    @Binding var components: [Component]
    // empty component that gathers information from user
    @State private var newComponent = Component()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
            // DestinationView where the user can add a new RecipeComponent
            let addComponentView = DestinationView(component: $newComponent) { component in
                components.append(component)
                newComponent = Component()
            }
                .navigationTitle("Add \(Component.singularName().capitalized)")
            
            // add a button to add first componenet if there are none
            if components.isEmpty {
                Spacer()
                NavigationLink("Add the first \(Component.singularName())", destination: addComponentView)
                Spacer()
            } else {
                // show list of current RecipeComponents
                HStack {
                    Text("\(Component.pluralName().capitalized)")
                        .font(.title)
                        .padding()
                    Spacer()
                }
                List {
                    ForEach(components.indices, id: \.self) { index in
                        let component = components[index]
                        
                        // create a view where user can edit a specific component
                        let editComponentView = DestinationView(component: $components[index]) { _ in
                            return
                        }
                            .navigationTitle("Edit " + "\(Component.singularName().capitalized)")
                        
                        // lead user to the view above on tap
                        NavigationLink(component.description, destination: editComponentView)
                    }
                    .listRowBackground(listBackgroundColor)
                    NavigationLink("Add another \(Component.singularName())", destination: addComponentView)
                        .buttonStyle(PlainButtonStyle())
                        .listRowBackground(listBackgroundColor)
                }
                .foregroundStyle(listTextColor)
            }
        }
    }
}

#Preview {
    @State var recipe = Recipe.testRecipes[1]
    //@State var emptyIngredients = [Ingredient]()
    
    return NavigationView { ModifyComponentsView<Ingredient, ModifyIngredientView>(components: $recipe.ingredients)}
}
