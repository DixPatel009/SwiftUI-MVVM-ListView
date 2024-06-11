//
//  Product.swift
//  SwiftUIListView
//
//  Created by Dixit Mac New on 10/06/24.
//

import Foundation

// MARK: - Product Data
struct Product: Codable, Identifiable {
    
    let id = UUID() // this is add for random id genrate which is used in create cell list unique id
    var image: String?
    var product_name: String?
    var product_type: String?
    var price: Float?
    var tax: Float?
}

//Generate Sample Data For Testing Purpose
struct MockData {
    static let sampleProduct = Product(image: "https://vx-erp-product-images.s3.ap-south-1.amazonaws.com/9_1717954769_0_image.jpg",
                                       product_name: "Samsung",
                                       product_type: "Electronics",
                                       price: 18000.0,
                                       tax: 18.0)
}

