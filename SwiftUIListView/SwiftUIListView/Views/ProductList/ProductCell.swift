//
//  ProductCell.swift
//  SwiftUIListView
//
//  Created by Dixit Mac New on 10/06/24.
//

import SwiftUI

struct ProductCell: View {

    //MARK:- PROPERTIES
    let product: Product
    
    //MARK:- BODY
    var body: some View {
        ZStack{
            Color.white
            
            VStack(alignment: .leading) {
                ProductRemoteImage(urlString: product.image ?? "")
                    .cornerRadius(8.0)
                    .frame(maxWidth: 180, maxHeight: 180)
                    .aspectRatio(contentMode: .fit)
                
                Text(product.product_name ?? "")
                    .font(.subheadline).bold()
                
                Text(product.product_type ?? "")
                    .font(.caption)
                
                HStack {
                    Text("₹\(product.price?.clean ?? "0.0")")
                        .font(.caption).bold()
                    
                    Text("+ \(product.tax?.clean ?? "")% tax")
                        .font(.caption)
                }
                
            }
            .padding(.horizontal, 8).padding(.vertical, 8)
            
        }
        .cornerRadius(8.0)
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
    }
    
}


struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductCell(product: MockData.sampleProduct)
    }
}
