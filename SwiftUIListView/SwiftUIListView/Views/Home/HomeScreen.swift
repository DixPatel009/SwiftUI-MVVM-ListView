//
//  HomeScreen.swift
//  SwiftUIListView
//
//  Created by Dixit Mac New on 10/06/24.
//

import SwiftUI

struct HomeScreen: View {
    
    //MARK:- PROPERTIES
    @StateObject var productsVM = ProductListViewModel()
    @State private var searchText: String = ""
    
    var filteredProducts: [Product] {
        if searchText.count == 0 {
            return productsVM.Products
        } else {
            return productsVM.Products.filter { $0.product_name?.lowercased().contains(searchText.lowercased()) ?? false}
        }
    }
    
    var gridItemLayout = [GridItem(.adaptive(minimum: 160))]
    
    //MARK:- BODY
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottomTrailing){
                
                ZStack(alignment: .center) {
                    ScrollView {
                        LazyVGrid(columns: gridItemLayout) {
                            ForEach(filteredProducts, id: \.self.id) { product in
                                ProductCell(product: product)
                            }
                        }.padding(.horizontal, 16)
                    }
                    .background(Color(uiColor: .systemGray5))
                    .refreshable {
                        productsVM.fetchProducts()
                    }
                    .navigationTitle("Products")
                    .searchable(text: $searchText).scrollDismissesKeyboard(.immediately)
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .disabled(true)
                        .isHidden(!productsVM.isLoading)
                    
                }
                                
                Button {
                    // Action
                } label: {
                    Image(systemName: "plus")
                        .font(.title.weight(.semibold))
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 4, x: 0, y: 4)
                    
                }.padding()
                                
            }
        }
        
    }
}

#Preview {
    HomeScreen()
}
