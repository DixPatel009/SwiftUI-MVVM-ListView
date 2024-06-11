//
//  ProductListViewModel.swift
//  SwiftUIListView
//
//  Created by Dixit Mac New on 10/06/24.
//

import Foundation

class ProductListViewModel: ObservableObject {
    
    //MARK:- PROPERTIES
    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var alertItem: AlertItem?
    @Published var productTypes: [String] = []
    @Published var isError = false
    
    init(isLoad: Bool) {
        if isLoad {
            fetchProducts()
        }
    }
    
    //MARK: - API call to get product list
    func fetchProducts() {
        
        self.isLoading = true
        self.products = []
        
        APIService.shared.getRequest(endPoint: APIEndpoint.getProducts) { [unowned self] result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result{
                case .success(let items):
                    self.products = items
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        self.alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        self.alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        self.alertItem = AlertContext.unableToComplete
                    }
                    self.isError = true
                }
            }
        }
        
    }
    
}
