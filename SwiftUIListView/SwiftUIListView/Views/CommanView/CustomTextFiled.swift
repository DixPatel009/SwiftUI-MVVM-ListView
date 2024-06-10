//
//  CustomTextFiled.swift
//  SwiftUIListView
//
//  Created by Dixit Mac New on 10/06/24.
//

import SwiftUI

struct CustomTextFiled: View {
    
    let placeHolder: String
    var keyboardType: UIKeyboardType = .default
    var error: String?
    
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField(placeHolder, text: $text)
                .textFieldStyle(OutlinedTextFieldStyle())
                .multilineTextAlignment(.leading)
                .keyboardType(keyboardType)
                .padding(.bottom, (error != nil ) ? 0.0 : 8.0)
            if let error = error {
                ErrorView(error: error).padding(.bottom, 8.0)
            }
        }
        

    }
}

struct OutlinedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color(UIColor.systemGray4), lineWidth: 2)
            }
    }
}
