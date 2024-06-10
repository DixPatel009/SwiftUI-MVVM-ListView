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
    
    func getProductList(completion : @escaping (Result<[Product],APError>) -> ()){
                
        guard let url = APIEndpoint.getProducts.url else {
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
                print(url)
                print(tempData)
            }
            catch (let error){
                print(error)
                completion(.failure(.invalidData))
            }
            
        }.resume()
        
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
