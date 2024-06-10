//
//  ProductListViewModel.swift
//  SwiftUIListView
//
//  Created by Dixit Mac New on 10/06/24.
//

import Foundation

class ProductListViewModel: ObservableObject {
    
    @Published var Products: [Product] = []
    @Published var isLoading = false
    @Published var alertItem: AlertItem?
    
    init() {
        fetchProducts()
    }
    
    //MARK: - API call to get product list
    func fetchProducts() {
        
        self.isLoading = true
        self.Products = []
        
        APIService.shared.getProductList { [unowned self] result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result{
                case .success(let items):
                    self.Products = items
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
                }
            }
        }
        
    }
}
