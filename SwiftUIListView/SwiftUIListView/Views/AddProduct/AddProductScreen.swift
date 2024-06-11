//
//  AddProductScreen.swift
//  SwiftUIListView
//
//  Created by Dixit Mac New on 10/06/24.
//

import SwiftUI

struct AddProductScreen: View {
    
    //MARK:- PROPERTIES
    @State private var isShowPhotoLibrary = false
    @Binding var productList: [Product]
    @StateObject var productTypeVM = SelectProductTypeViewModel()
    @StateObject var addProductVM = AddProductViewModel()
    
    //For get and set data
    @State private var productName = ""
    @State private var productPrice = ""
    @State private var productTax = ""
    @State private var image = UIImage(named: "ic_add_image.png")!
    
    //For Error Handler
    @State private var productNameError: String?
    @State private var productTypeError: String?
    @State private var productPriceError: String?
    @State private var productTaxError: String?
    
    @EnvironmentObject var productViewModel: ProductListViewModel
    @Environment(\.dismiss) var dismiss
    
    //MARK:- BODY
    var body: some View {
        
        ZStack(alignment: .center) {
            ScrollView {
                VStack(alignment: .leading){
                    Image(uiImage: self.image)
                        .resizable()
                        .scaledToFit()
                        .tint(Color.black)
                        .background(Color.gray.opacity(0.3)).frame(width: 160.0, height: 160.0).onTapGesture {
                            self.isShowPhotoLibrary = true
                        }.cornerRadius(8.0)
                        .padding(.bottom, 8.0)
                    
                    NavigationLink(destination: SelectProductType(productList: $productList).environmentObject(productTypeVM)){
                        CustomTextFiled(placeHolder: "Select Product Type", error: productTypeError, isShowSelectionIcon: true, text: $productTypeVM.selectedProductType)
                    }
                    
                    CustomTextFiled(placeHolder: "Enter Product Name", error: productNameError, text: $productName)
                    
                    CustomTextFiled(placeHolder: "Enter Selling Price", keyboardType: UIKeyboardType.decimalPad, error: productPriceError, text: $productPrice)
                    
                    CustomTextFiled(placeHolder: "Enter Tax Rate (%)", keyboardType: UIKeyboardType.decimalPad, error: productTaxError, text: $productTax)
                    
                    CustomButton(title: "Add Product") {
                        self.submitProduct()
                    }.padding(.vertical,32.0)
                    
                    Spacer()
                    
                }.padding().sheet(isPresented: $isShowPhotoLibrary) { //show image picker
                    ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
                }
            }.scrollDismissesKeyboard(.immediately)
            
            //show progress view
            ProgressView()
                .scaleEffect(4)
                .progressViewStyle(CircularProgressViewStyle())
                .disabled(true)
                .isHidden(!addProductVM.isLoading)
        }
        .navigationTitle("Add Product")
        .navigationBarTitleDisplayMode(.inline)
        .alert( //show error and success alert
            addProductVM.alertItem?.title ?? "Success",
            isPresented: $addProductVM.isShowAlert,
            presenting: addProductVM.alertItem?.message
        ) { message in
            Button("Done") {
                if(addProductVM.successResponse.success != nil){
                    productViewModel.fetchProducts()
                    dismiss()
                }
            }
        } message: { message in
            Text(addProductVM.alertItem?.message ?? "Save Successfully")
        }
        
    }
    
    //Click on Submit Button Validate All Filed
    func submitProduct() {
        
        var isValid = true
        
        // Validate Product Type
        if (productTypeVM.selectedProductType.isEmpty) || (productTypeVM.selectedProductType == "") {
            productTypeError = "Please Select Product type"
            isValid = false
        } else {
            productTypeError = nil
        }
        
        // Validate Product Name
        if productName.isEmpty {
            productNameError = "Please Enter Product name"
            isValid = false
        } else {
            productNameError = nil
        }
        
        // Validate Product Price
        if productPrice.isEmpty {
            productPriceError = "Please Enter Product price"
            isValid = false
        } else if Double(productPrice) == nil {
            productPriceError = "Product price must be a valid number"
            isValid = false
        } else {
            productPriceError = nil
        }
        
        // Validate Product Tax
        if productTax.isEmpty {
            productTaxError = "Please Enter Product Tax"
            isValid = false
        } else if Double(productTax) == nil {
            productTaxError = "Product tax must be a valid number"
            isValid = false
        } else {
            productTaxError = nil
        }
        
        // If all validations pass, submit the product
        if isValid {
            self.createParamForAPI()
        }
        
    }
    
    //Create Request Parameters and API Calling
    func createParamForAPI(){
        
        var param: [String: Any] = ["product_type": productTypeVM.selectedProductType,
                                    "product_name": productName,
                                    "price": productPrice,
                                    "tax": productTax,]
        
        if image != UIImage(named: "ic_add_image.png")! {
            param["files[]"] = image
        }
        
        addProductVM.addProducts(params: param)
    }
    
}
