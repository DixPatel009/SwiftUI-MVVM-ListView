//
//  APIService.swift
//  SwiftUIListView
//
//  Created by Dixit Mac New on 10/06/24.
//

import Foundation
import UIKit

class APIService: NSObject {
    
    static let shared = APIService()
    private let cache = NSCache<NSString, UIImage>() //store image in cache file for not call api every time
    
    private override init(){}
    
    func getProductList(endPoint: APIEndpoint ,completion : @escaping (Result<[Product],APError>) -> ()){
        
        guard let url = endPoint.url else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let _ = error{
                completion(.failure(.unableToComplete))
                return
            }
            guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do{
                let jsonDecoder = JSONDecoder()
                let tempData = try jsonDecoder.decode([Product].self, from: data)
                completion(.success(tempData))
            }
            catch (_){
                completion(.failure(.invalidData))
            }
            
        }.resume()
        
    }
    
    func uploadProductData(param: [String: Any], endPoint: APIEndpoint ,completion: @escaping (Result<AddProductSuccess,APError>) -> ()){
        guard let url = endPoint.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let body = createMultipartBody(parameters: param, boundary: boundary)
        request.httpBody = body
                
        URLSession.shared.dataTask(with: request) { data, urlResponse, error in
            
            if let _ = error{
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do{
                let jsonDecoder = JSONDecoder()
                let tempData = try jsonDecoder.decode(AddProductSuccess.self, from: data)
                completion(.success(tempData))
            }
            catch (_){
                completion(.failure(.invalidData))
            }
            
        }.resume()
    }
    
    func createMultipartBody(parameters: [String: Any], boundary: String) -> Data {
        var body = Data()
        
        for (key, value) in parameters {
            
            if let vS = value as? String {
                
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.append("\(vS)\r\n")
                
            }else if let image = value as? UIImage {
                
                let imageData = image.jpegData(compressionQuality: 1)!
                let filename = Date.currentTimeStampInString + "_product_image.jpg"
                let mimetype = "image/jpeg"
                
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n")
                body.append("Content-Type: \(mimetype)\r\n\r\n")
                body.append(imageData)
                body.append("\r\n")
                
            }
            
        }
        
        body.append("--\(boundary)--\r\n")
        
        return body
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}
