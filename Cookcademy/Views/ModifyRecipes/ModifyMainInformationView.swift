//
//  ModifyMainInformationView.swift
//  Cookcademy
//
//  Created by Henrique Barreto on 8/19/25.
//

import SwiftUI

struct ModifyMainInformationView: View {
    @Binding var mainInformation: MainInformation
    
    var body: some View {
        Form {
            TextField("Recipe Name", text: $mainInformation.name)
            TextField("Author", text: $mainInformation.author)
            
            Section {
                TextEditor(text: $mainInformation.description)
            } header: {
                Text("Description")
            }
            
            Picker("Category", selection: $mainInformation.category) {
                ForEach(MainInformation.Category.allCases, id: \.self) { category in
                    Text(category.rawValue)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
    }
}

#Preview {
    @State var mainInformation = MainInformation(name: "", description: "", author: "", category: MainInformation.Category.breakfast)
    return ModifyMainInformationView(mainInformation: $mainInformation)
}
