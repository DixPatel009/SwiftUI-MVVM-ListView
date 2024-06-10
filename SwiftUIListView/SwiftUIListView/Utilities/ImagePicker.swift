//
//  ImagePicker.swift
//  SwiftUIListView
//
//  Created by Dixit Mac New on 10/06/24.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
  
            if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage  = resizeImage(image: imageOriginal)
            }
            if let imageEdited = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                parent.selectedImage  = imageEdited
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func resizeImage(image: UIImage) -> UIImage {
            let width = image.size.width
            let height = image.size.height
            UIGraphicsBeginImageContext(CGSize(width: width, height: height))
            image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage!
        }
        
    }
}

