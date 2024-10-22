//
//  ErrorView.swift
//  SwiftUIListView
//
//  Created by Dixit Mac New on 10/06/24.
//

import SwiftUI

//Create Custom Comman ErrorView
struct ErrorView: View {
    
    //MARK:- PROPERTIES
    var error: String
    
    //MARK:- BODY
    var body: some View {
        Text(error)
            .foregroundColor(.red)
            .font(.caption).padding(.bottom, 8.0)
    }
}

#Preview {
    ErrorView(error: "Preview Error")
}
