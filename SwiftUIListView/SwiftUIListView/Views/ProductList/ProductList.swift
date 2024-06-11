//
//  ProductList.swift
//  SwiftUIListView
//
//  Created by Dixit Mac New on 10/06/24.
//

import SwiftUI

struct ProductList: View {
    
    //MARK:- PROPERTIES
    @StateObject var productsVM = ProductListViewModel(isLoad: true)
    @State private var searchText: String = ""
    @State private var isAddProduct: Bool = false
    
    //filter product based on search
    var filteredProducts: [Product] {
        if searchText.count == 0 {
            return productsVM.products
        } else {
            return productsVM.products.filter { $0.product_name?.lowercased().contains(searchText.lowercased()) ?? false}
        }
    }
    
    var gridItemLayout = [GridItem(.adaptive(minimum: 160))]
    
    //MARK:- BODY
    var body: some View {
        NavigationView{
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
                    .refreshable { //Pull to refresh
                        productsVM.fetchProducts()
                    }
                    .navigationTitle("Products")
                    .searchable(text: $searchText)
                    .scrollDismissesKeyboard(.immediately)
                    
                    ProgressView()
                        .scaleEffect(4)
                        .progressViewStyle(CircularProgressViewStyle())
                        .disabled(true)
                        .isHidden(!productsVM.isLoading)
                    
                }
                
                //Floating Action Button For Add Product
                NavigationLink(destination: AddProductScreen(productList: $productsVM.products).environmentObject(productsVM), isActive: $isAddProduct) {
                    Button {
                        self.isAddProduct = true
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
            }.onAppear(){
                //productsVM.fetchProducts()
            }.alert( //Show popup for error
                productsVM.alertItem?.title ?? "",
                isPresented: $productsVM.isError,
                presenting: productsVM.alertItem?.message ?? ""
            ) { message in
                Button("Ok") {
                }
            } message: { message in
                Text(productsVM.alertItem?.message ?? "")
            }
        }
    }
}

#Preview {
    ProductList()
}
