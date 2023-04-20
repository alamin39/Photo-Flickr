//
//  ViewModel.swift
//  Photo Flickr
//
//  Created by Al-Amin on 2023/04/20.
//

import Foundation

final class ViewModel {
    
    private(set) var allPhotos = [Photo]()
    
    func searchPhotos(query: String, completion: @escaping() -> Void) {
        NetworkManager.shared.searchPhotos(query: query, completion: { [weak self] photos, error in
            guard let photos = photos else {
                return
            }
            
            self?.allPhotos = photos.photos.photo
            DispatchQueue.main.async {
                completion()
            }
        })
    }
    
}
