//
//  SelectProductType.swift
//  SwiftUIListView
//
//  Created by Dixit Mac New on 10/06/24.
//

import SwiftUI

struct SelectProductType: View {
    
    //MARK:- PROPERTIES
    @Binding var productList: [Product]
    
    @EnvironmentObject var productTypeVM: SelectProductTypeViewModel
    @Environment(\.dismiss) var dismiss
    
    //MARK:- BODY
    var body: some View {
        List(productTypeVM.productTypes, id: \.self) { list in
            Button(action: {
                productTypeVM.selectedProductType = list
                dismiss()
            }) {
                HStack{
                    Text(list)
                    Spacer()
                    Image(systemName: (productTypeVM.selectedProductType == list) ? "checkmark.circle.fill" : "circle").frame(width: 16, height: 16)
                }.padding(.vertical, 8.0)
                
            }.foregroundColor(.black)
        }
        .navigationTitle("Select Product Type")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: { self.productTypeVM.filterOnlyProductType(products: productList) })
    }
}
