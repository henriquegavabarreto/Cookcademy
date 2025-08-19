//
//  ModifyMainInformationView.swift
//  Cookcademy
//
//  Created by Henrique Barreto on 8/19/25.
//

import SwiftUI

struct ModifyMainInformationView: View {
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    @Binding var mainInformation: MainInformation
    
    var body: some View {
        Form {
            TextField("Recipe Name", text: $mainInformation.name)
                .listRowBackground(listBackgroundColor)
            TextField("Author", text: $mainInformation.author)
                .listRowBackground(listBackgroundColor)
            Section {
                TextEditor(text: $mainInformation.description)
                    .listRowBackground(listBackgroundColor)
            } header: {
                Text("Description")
            }
            
            Picker("Category", selection: $mainInformation.category) {
                ForEach(MainInformation.Category.allCases, id: \.self) { category in
                    Text(category.rawValue)
                }
            }
            .listRowBackground(listBackgroundColor)
            .pickerStyle(MenuPickerStyle())
        }
        .foregroundStyle(listTextColor)
    }
}

#Preview {
    @State var mainInformation = MainInformation(name: "", description: "", author: "", category: MainInformation.Category.breakfast)
    return ModifyMainInformationView(mainInformation: $mainInformation)
}
