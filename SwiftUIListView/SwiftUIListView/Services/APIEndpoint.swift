//
//  APIEndpoint.swift
//  SwiftUIListView
//
//  Created by Dixit Mac New on 10/06/24.
//

import Foundation

//Network Request Base URL
private let baseURL = URL(string: "https://app.getswipe.in/api/public/")

//Network Request End Point
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
