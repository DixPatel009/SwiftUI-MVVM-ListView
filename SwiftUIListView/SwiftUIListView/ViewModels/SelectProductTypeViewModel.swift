//
//  SelectProductTypeViewModel.swift
//  SwiftUIListView
//
//  Created by Dixit Mac New on 10/06/24.
//

import Foundation

class SelectProductTypeViewModel: ObservableObject {
    
    //MARK:- PROPERTIES
    @Published var productTypes: [String] = []
    @Published var selectedProductType: String = ""
    
    init() {
    }
    
    //Filter and get product type from product list
    func filterOnlyProductType(products: [Product]){
        
        var productTypeTempArray: [String] = []
        
        for i in products {
            if let type = i.product_type, !productTypeTempArray.contains(type) {
                productTypeTempArray.append(type)
            }
        }
        
        productTypes = productTypeTempArray
    }
    
}
