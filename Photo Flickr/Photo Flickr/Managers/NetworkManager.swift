//
//  NetworkManager.swift
//  Photo Flickr
//
//  Created by Al-Amin on 2023/04/20.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func searchPhotos(query: String, completion: @escaping (AllPhotos?, Error?) -> Void) {
        let apiKey = "8783c0691476494275542a865171f6a3"
        let baseURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&format=json&nojsoncallback=1"
        let urlString = "\(baseURL)&text=\(query)"
        
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "No data received", code: 0, userInfo: nil))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AllPhotos.self, from: data)
                completion(result, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
