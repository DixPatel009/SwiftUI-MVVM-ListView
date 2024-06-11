# SwiftUI-MVVM-ListView

This project is a simple example of using SwiftUI with MVVM architecture to list and add products by calling an API.

## Features

- Fetch and display a list of products from an API
- Add a new product via an API call
- Uses Combine framework for handling asynchronous events

## Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.3+

## Installation

1. Clone the repository:

   - https://github.com/DixPatel009/SwiftUI-MVVM-ListView.git

3. Open the project in Xcode:

    - open SwiftUIListView.xcodeproj

3. Build and run the project on your preferred simulator or device.

## Usage

1. Launch the app.
2. You will see a list of products fetched from the API.
3. Tap the "+" button to add a new item.
4. Enter the product details and add product.
5. The new product will be added to the list.

## Architecture

The project follows the MVVM architecture pattern:

  - Model: Represents the data and business logic. This includes API data models.
  - View: SwiftUI views that display the data.
  - ViewModel: Manages the data for a view by interacting with the model and preparing the data for presentation in the view.

## Project Structure

    SwiftUIListView/
    ├── SwiftUIListViewApp.swift  # Entry point of the app
    ├── Models/
    │   ├── Product.swift                             # Data model for items fetched from the API
    │   ├── AddProductSuccess.swift                   # Data model for add item response
    ├── Views/
    │   ├── Splash/         
    │   │    ├── SplashScreen.swift                   # Splash with center app logo
    │   ├── ProductList/         
    │   │    ├── ProductList.swift                    # Main view displaying the list all products
    │   │    └── ProductCell.swift                    # Single product row screen
    │   ├── AddProduct/         
    │   │    ├── AddProductScreen.swift               # Add product screen design
    │   │    └── SelectProductType.swift              # Select product type screen design
    │   ├── CommanView/         
    │   │    ├── CustomButton.swift                   # Create customzied button for app
    │   │    └── CustomTextFiled.swift                # Create customzied textfiled for app
    │   │    └── ErrorView.swift                      # Create customzied textfiled validation error view
    ├── ViewModels/
    │   └── ProductListViewModel.swift                # ViewModel for managing products data
    │   └── AddProductViewModel.swift                 # ViewModel for managing add product data
    │   └── SelectProductTypeViewModel.swift          # ViewModel for managing product type data
    ├── Services/
    │   └── APIService.swift                          # Service for making APIs calls
    │   └── APIEndpoint.swift                         # Handle base url and apis end points
    └── Extension/                                    # Enhance existing types with new functionality
        └── Data.swift                                
        └── Date.swift                                
        └── Float.swift                               
        └── View.swift                                

## Acknowledgements

  - SwiftUI Documentation
  - MVVM Architecture Patterns

## Contact

  - For any questions or suggestions, please open an issue or contact akabaridixit009@gmail.com


