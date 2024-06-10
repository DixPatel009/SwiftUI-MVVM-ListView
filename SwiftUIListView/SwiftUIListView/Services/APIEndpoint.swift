//
//  APIEndpoint.swift
//  SwiftUIListView
//
//  Created by Dixit Mac New on 10/06/24.
//

import Foundation

private let baseURL = URL(string: "https://app.getswipe.in/api/public/")

enum APIEndpoint: Endpoint {    
    
    var url: URL? {
        return URL(string: self.path, relativeTo: baseURL)
    }
    
    var path: String {
        switch self {
        case .getProducts: return "get"
        case .addProduct: return "add"
        }
    }
    
    case getProducts
    case addProduct
}
