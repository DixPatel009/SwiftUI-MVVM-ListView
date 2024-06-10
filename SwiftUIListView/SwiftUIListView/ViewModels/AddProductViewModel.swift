//
//  AddProductViewModel.swift
//  SwiftUIListView
//
//  Created by Dixit Mac New on 10/06/24.
//

import Foundation

class AddProductViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var alertItem: AlertItem?
    @Published var successResponse = AddProductSuccess()
    @Published var isShowAlert = false
    
    init() {
        
    }
    
    //MARK: - API call to get product list
    func addProducts(params: [String: Any]) {
        self.isLoading = true
        APIService.shared.uploadProductData(param: params, endPoint: APIEndpoint.addProduct) { [unowned self] result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result{
                case .success(let item):
                    self.successResponse = item
                    self.alertItem = AlertItem(title: "Success", message: item.message ?? "Save Successfully")
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
                self.isShowAlert = true
            }
        }
    }
}
