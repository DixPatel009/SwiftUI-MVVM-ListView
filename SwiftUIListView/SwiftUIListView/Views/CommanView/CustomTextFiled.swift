//
//  CustomTextFiled.swift
//  SwiftUIListView
//
//  Created by Dixit Mac New on 10/06/24.
//

import SwiftUI

//Create Custom Comman Textfiled
struct CustomTextFiled: View {
    
    //MARK:- PROPERTIES
    let placeHolder: String
    var keyboardType: UIKeyboardType = .default
    var error: String?
    var isShowSelectionIcon: Bool = false
    
    @Binding var text: String
    
    //MARK:- BODY
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .center) {
                
                TextField(placeHolder, text: $text)
                    .textFieldStyle(OutlinedTextFieldStyle())
                    .multilineTextAlignment(.leading)
                    .keyboardType(keyboardType)
                    .padding(.bottom, (error != nil ) ? 0.0 : 8.0)
                
                //For Selection Icon
                if (isShowSelectionIcon){
                    HStack {
                        Spacer()
                        Image(systemName: "chevron.forward")
                            .resizable()
                            .scaledToFit()
                            .tint(Color(UIColor.systemGray4))
                            .frame(width: 16, height: 16).padding(.horizontal, 16.0).padding(.bottom, (error != nil ) ? 0.0 : 8.0)
                    }
                }
                
            }
            
            //Show error
            if let error = error {
                ErrorView(error: error).padding(.bottom, 8.0)
            }
        }
        
        
    }
}

//Create Custom Textfiled Style
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
